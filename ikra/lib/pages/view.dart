import 'package:flutter/material.dart';
import 'package:ikra/design/iconbar.dart';
import 'package:ikra/Db/bookData.dart';
import '../design/view/apppbar.dart';
import '../design/view/authoritem.dart';
import '../design/view/bookitem.dart';
import '../design/view/togglebutton.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool isBooksSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141B24),
      appBar: appbar(isBooksSelected: isBooksSelected),
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
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          toggleButton(
                              title: "Books",
                              isSelected: isBooksSelected,
                              onTap: () {
                                setState(() {
                                  isBooksSelected = true;
                                });
                              }),
                          toggleButton(
                              title: "Authors",
                              isSelected: !isBooksSelected,
                              onTap: () {
                                setState(() {
                                  isBooksSelected = false;
                                });
                              }),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: isBooksSelected
                              ? BookData.books.length
                              : BookData.authors.length,
                          itemBuilder: (context, index) {
                            if (isBooksSelected) {
                              final book = BookData.books[index];
                              return BookItem(context: context, book: book);
                            } else {
                              final author = BookData.authors[index];
                              return AuthorItem(
                                  context: context, author: author);
                            }
                          },
                        ),
                      ),
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
}
