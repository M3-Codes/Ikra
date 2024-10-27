// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class Logo_ikra_M extends StatelessWidget {
  const Logo_ikra_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      child: Image.asset(
        "images/ikraWhite.png",
        width: 600, // تحديد عرض الصورة إذا لزم الأمر
        height: 300, // تحديد ارتفاع الصورة إذا لزم الأمر
      ),
    );
  }
}
