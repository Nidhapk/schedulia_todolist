import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class CustomPicker extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  const CustomPicker(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: textformColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1)),
      child: Row(
        children: [
          Text(text),
          IconButton(onPressed: onPressed, icon: Icon(icon))
        ],
      ),
    );
  }
}
