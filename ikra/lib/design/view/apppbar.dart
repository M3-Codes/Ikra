import 'package:flutter/material.dart';

import '../textfont.dart';

class appbar extends StatelessWidget implements PreferredSizeWidget {
  const appbar({
    super.key,
    required this.isBooksSelected,
  });

  final bool isBooksSelected;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
