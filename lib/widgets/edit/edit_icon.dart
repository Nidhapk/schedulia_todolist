import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class EditIcon extends StatelessWidget {
  final VoidCallback onpressed;
  const EditIcon({super.key, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onpressed,
      icon: Padding(
        padding: const EdgeInsets.only(left: 320, top: 50),
        child: Icon(
          Icons.edit,
          color: white,
          size: 30,
        ),
      ),
    );
  }
}
