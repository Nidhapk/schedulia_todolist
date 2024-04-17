import 'package:flutter/material.dart';

class CustomAlertBox extends StatelessWidget {
  final String text;
  final String title;
  final VoidCallback onpressedCancel;
  final VoidCallback onpressedDelete;
  const CustomAlertBox(
      {super.key,
      required this.text,
      required this.title,
      required this.onpressedCancel,
      required this.onpressedDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: const Color.fromRGBO(247, 246, 246, 1),
        //shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: Text(title),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
        content: Text(
          text,
        ),
        actions: [
          TextButton(
            onPressed: onpressedCancel,
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color.fromARGB(255, 206, 21, 79)),
            ),
          ),
          TextButton(onPressed: onpressedDelete, child: const Text('Delete'))
        ]);
  }
}
