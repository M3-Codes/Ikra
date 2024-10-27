// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class Logo_ikra_M extends StatelessWidget {
  final bool isWhite; // متغير لتحديد نوع الصورة

  const Logo_ikra_M({super.key, required this.isWhite});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: isWhite ? 70 : 10,
      child: Image.asset(
        isWhite ? "images/ikraWhite.png" : "images/ikraBlack.png",
        width: 600, // تحديد عرض الصورة إذا لزم الأمر
        height: 300, // تحديد ارتفاع الصورة إذا لزم الأمر
      ),
    );
  }
}
