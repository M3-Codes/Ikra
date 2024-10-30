import 'package:flutter/material.dart';

class Iconbar extends StatelessWidget {
  const Iconbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Color(0xFFA28D4F),
                size: 40,
              ),
              onPressed: () {
                // الإجراء عند الضغط على زر Home
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu_book_sharp,
                  color: Colors.white, size: 40),
              onPressed: () {
                // الإجراء عند الضغط على زر الكتاب
              },
            ),
            IconButton(
              icon: const Icon(Icons.bookmark, color: Colors.white, size: 40),
              onPressed: () {
                // الإجراء عند الضغط على زر المفضلة
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                // الإجراء عند الضغط على زر حول
              },
            ),
          ],
        ),
      ),
    );
  }
}
