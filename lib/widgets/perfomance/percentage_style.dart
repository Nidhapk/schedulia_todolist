import 'package:flutter/material.dart';

class Percentage extends StatelessWidget {
  final   String text;
  const Percentage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:const  TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    );
  }
}
