import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final String imagePath;
  final String releaseDate;
  final String category;
  final String summary;
  bool isFavorite;

  Book({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.releaseDate,
    required this.category,
    required this.summary,
    this.isFavorite = false,
  });
}

class Author {
  final String name;
  final String image;
  final String birthDate;
  final String nationality;
  final String biography;

  Author({
    required this.name,
    required this.image,
    required this.birthDate,
    required this.nationality,
    required this.biography,
  });
}

class BookData {
  static final List<Book> books = [
    Book(
      title: "All Fours",
      author: "Miranda July",
      imagePath: "images/book1.jpg",
      releaseDate: "14/05/2024",
      category: "Literary Fiction",
      summary:
          "The plot of 'All Fours' by Miranda July follows a semi-famous artist who embarks on a spontaneous cross-country road trip from Los Angeles to New York. Along the way, she makes an unexpected stop at a nondescript motel, where she begins a journey of self-discovery and reinvention.",
    ),
    Book(
      title: "The Secret History",
      author: "Donna Tartt",
      imagePath: "images/book2.jpg",
      releaseDate: "16/09/1992",
      category: "Mystery, Psychological Thriller",
      summary:
          "In 'The Secret History,' a group of eccentric and secretive students at an elite college in Vermont become entangled in a murder mystery that tests the boundaries of friendship and morality. Donna Tartt’s novel delves into themes of obsession, guilt, and the human psyche.",
    ),
    Book(
      title: "Buddenbrooks",
      author: "Thomas Mann",
      imagePath: "images/book3.jpg",
      releaseDate: "1901",
      category: "Historical Fiction",
      summary:
          "'Buddenbrooks' is a novel about the decline of a wealthy German merchant family over the course of four generations. Thomas Mann’s exploration of family dynamics, societal changes, and personal aspirations offers a richly detailed view of 19th-century Europe.",
    ),
  ];

  static final List<Author> authors = [
    Author(
      name: "James Patterson",
      image: "images/author1.png",
      birthDate: "March 22, 1947",
      nationality: "American",
      biography:
          "James Patterson is an American author and philanthropist known for his thrillers and crime novels. He has authored numerous bestselling books, including the Alex Cross and Women's Murder Club series.",
    ),
    Author(
      name: "Stephen King",
      image: "images/author2.png",
      birthDate: "September 21, 1947",
      nationality: "American",
      biography:
          "Stephen King is an American author of horror, supernatural fiction, suspense, and fantasy novels. His books have sold over 350 million copies, many of which have been adapted into films, television series, and miniseries.",
    ),
    Author(
      name: "Chuck Palahniuk",
      image: "images/author3.png",
      birthDate: "February 21, 1962",
      nationality: "American",
      biography:
          "Chuck Palahniuk is an American novelist and freelance journalist, known for his transgressive fiction novels. He is the author of 'Fight Club', which was adapted into a popular film in 1999.",
    ),
  ];
}

class FavoriteData with ChangeNotifier {
  List<Book> _favoriteBooks = [];

  List<Book> get favoriteBooks => _favoriteBooks;

  void addFavoriteBook(Book book) {
    if (!_favoriteBooks.contains(book)) {
      // Tekrar eklenmeyi önlemek için kontrol
      _favoriteBooks.add(book);
      book.isFavorite = true;
      notifyListeners();
    }
  }

  void removeFavoriteBook(Book book) {
    _favoriteBooks.remove(book);
    book.isFavorite = false;
    notifyListeners();
  }

  bool isFavorite(Book book) {
    return _favoriteBooks.contains(book);
  }
}
