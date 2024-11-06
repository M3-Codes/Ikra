import 'package:flutter/material.dart';
import 'package:ikra/design/iconbar.dart';

class Showbook extends StatefulWidget {
  final String title;
  final String author;
  final String imagePath;
  final String releaseDate;
  final String category;
  final String summary;

  const Showbook({
    Key? key,
    required this.title,
    required this.author,
    required this.imagePath,
    required this.releaseDate,
    required this.category,
    required this.summary,
  }) : super(key: key);

  @override
  State<Showbook> createState() => _ShowbookState();
}

class _ShowbookState extends State<Showbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
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
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      Image.asset(
                        widget.imagePath,
                        height: 200,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.author,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Release date: ${widget.releaseDate}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Category: ${widget.category}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.summary,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      // const Spacer(),
                      const SizedBox(height: 16),
                      IconButton(
                        icon: const Icon(
                          Icons.bookmark_add_outlined,
                          size: 45,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          // Kitabı eklemek için gerekli fonksiyonu buraya yazabilirsiniz
                          setState(() {
                            // Durum güncelleme işlemi buraya
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
            child: Iconbar(
              index: 2,
            ),
          ),
        ],
      ),
    );
  }
}
