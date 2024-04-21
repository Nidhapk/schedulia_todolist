import 'package:flutter/material.dart';

class ViewprofileRow extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback? onTap;
  const ViewprofileRow(
      {super.key, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Padding(
        padding: const EdgeInsets.only(left: 28.0),
        child: Text(text),
      ),
    );
    
  }
}

