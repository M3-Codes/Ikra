import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ikra/API/AuthService.dart';

class Author {
  final int id;
  final String name;
  final String image;
  final String birthDate;
  final String nationality;
  final String biography;

  Author({
    required this.id,
    required this.name,
    required this.image,
    required this.birthDate,
    required this.nationality,
    required this.biography,
  });
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
        id: json['id'],
        name: json['name'],
        image: json['imagePath'], //json['imagePath']
        birthDate: json['birthDate'],
        nationality: json['nationality'],
        biography: json['biography']);
  }
}

class Book {
  final int id;
  final String title;
  final String author;
  final String imagePath;
  final String releaseDate;
  final String category;
  final String summary;
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imagePath,
    required this.releaseDate,
    required this.category,
    required this.summary,
    this.isFavorite = false,
  });
  factory Book.fromJson(Map<String, dynamic> json) {
    final author = BookData.authors.firstWhere(
      (author) => author.id == json['writersId'],
      orElse: () => Author(
        id: -1,
        name: "Unknown Author",
        image: "",
        birthDate: "",
        nationality: "",
        biography: "",
      ),
    );

    return Book(
      id: json['id'],
      title: json['title'],
      author: author.name,
      imagePath: json['imagePath'], //json['imagePath']
      releaseDate: json['publicationDate'],
      category: json['category'],
      summary: json['summary'],
    );
  }
}

class BookData {
  static List<Book> books = [];
  static List<Author> authors = [];

  static Future<void> initializeData() async {
    authors = await fetchAuthors();
    books = await fetchBooks();

    //FavoriteData._favoriteBooks = await fetchFavorites();
  }

  static Future<List<Book>> fetchBooks() async {
    final response = await http.get(
        Uri.parse('https://b439-85-105-61-128.ngrok-free.app/api/v1/books'));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((json) => Book.fromJson(json))
            .toList();
      } else {
        throw Exception('Data is not a list');
      }
    } else {
      throw Exception('Failed to load books');
    }
  }

  static Future<List<Author>> fetchAuthors() async {
    final response = await http.get(
        Uri.parse('https://b439-85-105-61-128.ngrok-free.app/api/v1/writers'));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((json) => Author.fromJson(json))
            .toList();
      } else {
        throw Exception('Data is not a list');
      }
    } else {
      throw Exception('Failed to load books');
    }
  }

  static Future<List<int>> fetchFavorites() async {
    int? id = await TokenStorage.getID();

    print("sdsdssdsdsdskfokewovkovkokvo aaaaaaaaaaaaa${id.toString()}trtr");
    String url =
        'https://b439-85-105-61-128.ngrok-free.app/api/v1/favorites?userId[eq]=$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((json) => json['bookId'] as int)
            .toList();
      } else {
        throw Exception('Data is not a list');
      }
    } else {
      throw Exception('Failed to load Favorite');
    }
  }

  // static final Future<List<Book>> books = fetchBook();
}

class FavoriteData with ChangeNotifier {
  static List<Book> _favoriteBooks = [];

  List<Book> get favoriteBooks => _favoriteBooks;
  static void fillList(List<int> _favorite) {
    _favoriteBooks = [];
    for (int bookId in _favorite) {
      Book book = BookData.books.firstWhere(
        (b) => b.id == bookId,
        orElse: () => Book(
            id: -1,
            isFavorite: false,
            summary: '',
            title: '',
            author: '',
            imagePath: '',
            releaseDate: '',
            category: ''), // Handle cases where the book isn't found
      );

      if (book.id != -1) {
        _favoriteBooks.add(book);
      }
    }
    print(_favoriteBooks.length);
  }

  Future<void> addFavoriteBook(Book book) async {
    if (!_favoriteBooks.contains(book)) {
      _favoriteBooks.add(book);
      try {
        int? userId = await TokenStorage.getID();
        final response = await http.post(
          Uri.parse(
              'https://b439-85-105-61-128.ngrok-free.app/api/createFavorite'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': userId, 'bookId': book.id}),
        );

        if (response.statusCode == 201) {
          book.isFavorite = true;
          notifyListeners();
        } else {
          print('Error: ${response.body}');
        }
      } catch (e) {
        print('Exception: $e');
        return null;
      }
    }
  }

  Future<void> removeFavoriteBook(Book book) async {
    if (_favoriteBooks.contains(book)) {
      _favoriteBooks.remove(book);

      try {
        int? userId = await TokenStorage.getID();
        final response = await http.post(
          Uri.parse(
              'https://b439-85-105-61-128.ngrok-free.app/api/removeFavorite'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': userId, 'bookId': book.id}),
        );

        if (response.statusCode == 201) {
          book.isFavorite = false;
          notifyListeners();
        } else {
          print('Error: ${response.body}');
        }
      } catch (e) {
        print('Exception: $e');
        return null;
      }
    }
  }

  bool isFavorite(Book book) {
    return _favoriteBooks.contains(book);
  }
}
