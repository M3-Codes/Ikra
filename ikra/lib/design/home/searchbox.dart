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
  final FocusNode _focusNode = FocusNode(); // لإدارة التركيز
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose(); // تخلص من الـ FocusNode عند الانتهاء
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void _showOverlay(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.23, // تحديد موقع القائمة
        left: 24,
        right: 24,
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2833).withOpacity(0.9),
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
                          _removeOverlay();
                          widget.onSuggestionSelected?.call(book.title);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Showbook(book: book),
                            ),
                          );
                        },
                      )),
                  ...searchProvider.filteredAuthors.map((author) => ListTile(
                        title: Text(
                          author.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          author.nationality,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        onTap: () {
                          _removeOverlay();
                          widget.onSuggestionSelected?.call(author.name);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowAuthor(author: author),
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
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            focusNode: _focusNode, // ربط FocusNode بمربع النص
            onChanged: (value) {
              searchProvider.search(value);
              if (value.isNotEmpty) {
                _removeOverlay();
                _showOverlay(context);
              } else {
                _removeOverlay();
              }
            },
            onTap: () {
              if (_controller.text.isNotEmpty) {
                _showOverlay(context);
              }
            },
            onEditingComplete: () {
              _removeOverlay();
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
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // إذا فقد مربع النص التركيز، قم بإزالة القائمة
        _removeOverlay();
      }
    });
  }
}