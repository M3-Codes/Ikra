import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Db/search_provider.dart';
import '../../pages/showAuthor.dart';
import '../../pages/showBook.dart';

class SearchBox extends StatefulWidget {
  final ValueChanged<String>? onSuggestionSelected;

  const SearchBox({
    super.key,
    this.onSuggestionSelected,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _controller = TextEditingController();
  bool _showSuggestions = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Column(
      children: [
        // صندوق البحث
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: TextField(
            controller: _controller,
            onChanged: (value) {
              searchProvider.search(value);
              setState(() {
                _showSuggestions = value.isNotEmpty;
              });
            },
            onTap: () {
              setState(() {
                _showSuggestions = true;
              });
            },
            onEditingComplete: () {
              setState(() {
                _showSuggestions = false;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: '  Search for books or authors...',
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
              filled: true,
              fillColor: Colors.white.withOpacity(0.2),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // القائمة المنسدلة
        if (_showSuggestions)
          Positioned(
            top: 90,
            left: 24,
            right: 24,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 70, // عرض عدد محدود من الاقتراحات مع التمرير
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2833),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Scrollbar(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ...searchProvider.filteredBooks.map((book) => ListTile(
                            title: Text(
                              book.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'by ${book.author}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Showbook(book: book),
                                ),
                              );
                            },
                          )),
                      ...searchProvider.filteredAuthors
                          .map((author) => ListTile(
                                title: Text(
                                  author.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  author.nationality,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShowAuthor(author: author),
                                    ),
                                  );
                                },
                              )),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
