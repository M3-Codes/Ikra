// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class Logo_ikra_M extends StatelessWidget {
  const Logo_ikra_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 70,
        child: Container(
            alignment: Alignment.center,
            width: 300,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25)),
            child: Image.asset(
              "images/ikraWhite.png",
            )));
  }
}
