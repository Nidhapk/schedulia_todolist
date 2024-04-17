// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class EventButton extends StatelessWidget {
  String text;
  double width;
  VoidCallback onPressed;
  EventButton({super.key, required this.text, required this.onPressed,required this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(width, 50)),
          backgroundColor: MaterialStatePropertyAll(appBarColor),
          foregroundColor: MaterialStatePropertyAll(white)),
      onPressed: onPressed,
      child: Text(
        text,
      ),
    );
  }
}
