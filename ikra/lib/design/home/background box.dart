import 'package:flutter/material.dart';

import '../textfont.dart';

class backgroundbox extends StatelessWidget {
  const backgroundbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 130, // تقليل الحشو في الأسفل
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Textdesign(
              'Come to a book as you \n would come to an\n unexplored land',
              20,
              align: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 60), // مساحة بين النص والشريط
        ],
      ),
    );
  }
}
