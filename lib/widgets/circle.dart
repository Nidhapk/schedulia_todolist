import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(20.0, -90.0),
      child: Transform.rotate(
        angle: 30 * (3.141592653589793 / 180),
        child: Transform.scale(
          scale: 1.2,
          child: Container(
            height: 400.0,
            width: 430.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(500)),
              color: Color.fromRGBO(198, 176, 218, 0.6),
            ),
          ),
        ),
      ),
    );
  }
}
