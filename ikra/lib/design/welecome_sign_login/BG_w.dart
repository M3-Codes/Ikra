// ignore_for_file: file_names

import 'package:flutter/material.dart';



// ignore: camel_case_types
class BG_w extends StatelessWidget {
  const BG_w({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images\BooksBackground.png'), // ضع مسار الصورة هنا
          fit: BoxFit.cover, // يمكنك تعديل هذه الخاصية لتناسب الصورة بالشكل المطلوب
        ),
      ),
    );
  }
}

