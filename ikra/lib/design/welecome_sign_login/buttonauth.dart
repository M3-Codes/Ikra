import 'package:flutter/material.dart';

import '../textfont.dart';

class ButtonAtuh extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double horizontal;
  final Color colorbackround;
  final Color colorfont;
  const ButtonAtuh(
      {super.key,
      this.onPressed,
      required this.title,
      required this.horizontal,
      required this.colorbackround,
      required this.colorfont});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(colorbackround),
        padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: horizontal, vertical: 10)),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      ),
      child: Textdesign(
        title,
        20,
        color: colorfont,
      ),
    );
  }
}
