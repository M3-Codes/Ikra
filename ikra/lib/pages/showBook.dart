import 'package:flutter/material.dart';
import 'package:ikra/design/iconbar.dart';
import 'package:provider/provider.dart';
import '../Db/bookData.dart';

class Showbook extends StatefulWidget {
  final Book book;

  const Showbook({Key? key, required this.book}) : super(key: key);

  @override
  State<Showbook> createState() => _ShowbookState();
}

class _ShowbookState extends State<Showbook> {
  late Book book;

  @override
  void initState() {
    super.initState();
    book = widget.book;

    final favoriteData = context.read<FavoriteData>();
    if (favoriteData.isFavorite(book)) {
      book.isFavorite = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141B24),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          'Recommended books',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      Image.asset(
                        book.imagePath,
                        height: 200,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        book.author,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Release date: ${book.releaseDate}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Category: ${book.category}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          book.summary,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      IconButton(
                        icon: Icon(
                          book.isFavorite
                              ? Icons.bookmark
                              : Icons.bookmark_add_outlined,
                          size: 45,
                          color: book.isFavorite
                              ? const Color.fromARGB(255, 144, 39, 32)
                              : Colors.black87,
                        ),
                        onPressed: () {
                          setState(() {
                            if (book.isFavorite) {
                              context
                                  .read<FavoriteData>()
                                  .removeFavoriteBook(book);
                              book.isFavorite = false;
                            } else {
                              context
                                  .read<FavoriteData>()
                                  .addFavoriteBook(book);
                              book.isFavorite = true;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Iconbar(index: 0),
          ),
        ],
      ),
    );
  }
}
