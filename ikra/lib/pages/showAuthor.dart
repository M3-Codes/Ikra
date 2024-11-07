import 'package:flutter/material.dart';
import 'package:ikra/design/iconbar.dart';
import 'package:ikra/Db/bookData.dart';
import 'package:ikra/design/view/apppbar.dart';

import '../design/textfont.dart';

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
      appBar: const appbar(isBooksSelected: false),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
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
                      Textdesign(
                        widget.author.name,
                        24,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      Textdesign(
                        'Birth Date: ${widget.author.birthDate}',
                        16,
                        color: const Color.fromRGBO(97, 97, 97, 1),
                      ),
                      const SizedBox(height: 4),
                      Textdesign(
                        'Nationality: ${widget.author.nationality}',
                        16,
                        color: const Color.fromRGBO(97, 97, 97, 1),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Textdesign(
                          widget.author.biography,
                          align: TextAlign.center,
                          16,
                          color: const Color.fromRGBO(66, 66, 66, 1),
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
              bottom: 0, left: 0, right: 0, child: Iconbar(index: 0))
        ],
      ),
    );
  }
}
