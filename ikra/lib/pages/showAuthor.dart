import 'package:flutter/material.dart';
import 'package:ikra/design/iconbar.dart';
import 'package:ikra/pages/bookData.dart';

class ShowAuthor extends StatefulWidget {
  final Author author;

  const ShowAuthor({
    Key? key,
    required this.author,
  }) : super(key: key);

  @override
  State<ShowAuthor> createState() => _ShowAuthorState();
}

class _ShowAuthorState extends State<ShowAuthor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141B24),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          'Recommended author',
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
                      const SizedBox(height: 28),
                      Image.asset(
                        widget.author.image,
                        width: 120,
                        height: 180,
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.author.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Birth Date: ${widget.author.birthDate}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Nationality: ${widget.author.nationality}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.author.biography,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
              bottom: 0, left: 0, right: 0, child: Iconbar(index: 2))
        ],
      ),
    );
  }
}
