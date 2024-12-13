import 'package:flutter/material.dart';
import 'bookData.dart';

class SearchProvider with ChangeNotifier {
  List<Book> _filteredBooks = [];
  List<Author> _filteredAuthors = [];

  List<Book> get filteredBooks => _filteredBooks;
  List<Author> get filteredAuthors => _filteredAuthors;
  void clearSearch() {
    _filteredBooks = [];
    _filteredAuthors = [];
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredBooks = [];
      _filteredAuthors = [];
    } else {
      _filteredBooks = BookData.books
          .where((book) =>
              book.title.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()))
          .toList();

      _filteredAuthors = BookData.authors
          .where((author) =>
              author.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
