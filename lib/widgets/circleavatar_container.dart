import 'package:flutter/material.dart';

class CustomCircleavatar extends StatelessWidget {
  final ImageProvider<Object>? backgroundImage;
  const CustomCircleavatar({super.key, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        border: Border.all(
            color: const Color.fromARGB(255, 71, 50, 77), width: 3.0),
      ),
      child: CircleAvatar(backgroundImage: backgroundImage),
    );
  }
}
