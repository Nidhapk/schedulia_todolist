import 'package:flutter/material.dart';

class ProfileEB extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const ProfileEB({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        ),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        backgroundColor: const MaterialStatePropertyAll(
          Color.fromARGB(255, 59, 56, 63),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 108),
        child: Text(text),
      ),
    );
  }
}
