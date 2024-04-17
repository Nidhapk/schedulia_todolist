import 'package:flutter/material.dart';

class ProfileIconButton extends StatelessWidget {
  final VoidCallback onTap;
  const ProfileIconButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 55, left: 74),
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(
          Icons.add_a_photo,
          size: 30.0,
        ),
      ),
    );
  }
}
