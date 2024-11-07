import 'package:flutter/material.dart';
import 'package:ikra/design/iconbar.dart';
import 'package:ikra/design/textfont.dart';
import 'package:ikra/pages/showAuthor.dart';
import 'package:ikra/pages/showBook.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool isBooksSelected = true;

  final List<Map<String, String>> books = [
    {
      "title": "All Fours",
      "author": "Miranda July",
      "image": "images/book1.jpg",
      "releaseDate": "14/05/2024",
      "category": "Literary Fiction",
      "summary":
          "The plot of 'All Fours' by Miranda July follows a semi-famous artist who embarks on a spontaneous cross-country road trip from Los Angeles to New York. Along the way, she makes an unexpected stop at a nondescript motel, where she begins a journey of self-discovery and reinvention."
    },
    {
      "title": "The Secret History",
      "author": "Donna Tartt",
      "image": "images/book2.jpg",
      "releaseDate": "16/09/1992",
      "category": "Mystery, Psychological Thriller",
      "summary":
          "In 'The Secret History,' a group of eccentric and secretive students at an elite college in Vermont become entangled in a murder mystery that tests the boundaries of friendship and morality. Donna Tartt’s novel delves into themes of obsession, guilt, and the human psyche."
    },
    {
      "title": "Buddenbrooks",
      "author": "Thomas Mann",
      "image": "images/book3.jpg",
      "releaseDate": "1901",
      "category": "Historical Fiction",
      "summary":
          "'Buddenbrooks' is a novel about the decline of a wealthy German merchant family over the course of four generations. Thomas Mann’s exploration of family dynamics, societal changes, and personal aspirations offers a richly detailed view of 19th-century Europe."
    },
  ];

  final List<Map<String, String>> authors = [
    {
      "name": "James Patterson",
      "image": "images/author1.png",
      "birthDate": "March 22, 1947",
      "nationality": "American",
      "biography":
          "James Patterson is an American author and philanthropist known for his thrillers and crime novels. He has authored numerous bestselling books, including the Alex Cross and Women's Murder Club series."
    },
    {
      "name": "Stephen King",
      "image": "images/author2.png",
      "birthDate": "September 21, 1947",
      "nationality": "American",
      "biography":
          "Stephen King is an American author of horror, supernatural fiction, suspense, and fantasy novels. His books have sold over 350 million copies, many of which have been adapted into films, television series, and miniseries."
    },
    {
      "name": "Chuck Palahniuk",
      "image": "images/author3.png",
      "birthDate": "February 21, 1962",
      "nationality": "American",
      "biography":
          "Chuck Palahniuk is an American novelist and freelance journalist, known for his transgressive fiction novels. He is the author of 'Fight Club', which was adapted into a popular film in 1999."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141B24),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Textdesign(
                'Recommended ${isBooksSelected ? "Books" : "Authors"}',
                18,
                color: Colors.white,
              ),
            ],
          ),
        ),
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
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 0), // مساحة تحتية
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildToggleButton("Books", isBooksSelected, () {
                            setState(() {
                              isBooksSelected = true;
                            });
                          }),
                          _buildToggleButton("Authors", !isBooksSelected, () {
                            setState(() {
                              isBooksSelected = false;
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              isBooksSelected ? books.length : authors.length,
                          itemBuilder: (context, index) {
                            if (isBooksSelected) {
                              final book = books[index];
                              return _buildBookItem(
                                book["title"]!,
                                book["author"]!,
                                book["image"]!,
                                book["releaseDate"]!,
                                book["category"]!,
                                book["summary"]!,
                              );
                            } else {
                              final author = authors[index];
                              return _buildAuthorItem(
                                context,
                                author["name"]!,
                                author["image"]!,
                                author["birthDate"]!,
                                author["nationality"]!,
                                author["biography"]!,
                              );
                            }
                          },
                        ),
                      ), // Add any other content here
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Iconbar(index: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF141B24) : Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorItem(BuildContext context, String name, String imagePath,
      String birthDate, String nationality, String biography) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.asset(
              imagePath,
              width: 120,
              height: 180,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowAuthor(
                      name: name,
                      imagePath: imagePath,
                      birthDate: birthDate,
                      nationality: nationality,
                      biography: biography,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA28D4F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              child: const Text(
                "Show",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookItem(String title, String author, String imagePath,
      String releaseDate, String category, String summary) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 120,
              height: 180,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  author,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Showbook(
                            title: title,
                            author: author,
                            imagePath: imagePath,
                            releaseDate: releaseDate,
                            category: category,
                            summary: summary,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA28D4F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                    ),
                    child: const Text(
                      "Show",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
