import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class MultiLineText extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const MultiLineText(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Container(
        width: 370,
        decoration: BoxDecoration(
            border: Border.all(width: 3, color: grey),
            borderRadius: BorderRadius.circular(20),
            color: lightPurpleTextField),
        child: TextFormField(
          controller: controller,
          decoration: const InputDecoration(hintText: '   Task Note'),
          maxLines: 50,
          minLines: 3,
        ),
      ),
    );
  }
}
