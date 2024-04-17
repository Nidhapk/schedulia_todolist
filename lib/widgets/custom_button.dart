import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class Custombutton extends StatelessWidget {
  final String text;
  // final double? width;
  final VoidCallback onpressed;
  const Custombutton(
      {super.key,
      //  this.width,
      required this.onpressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),

      // width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(appBarColor),
          foregroundColor: MaterialStatePropertyAll(white),
        ),
        onPressed: onpressed,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 18, bottom: 18, left: 135, right: 135),
          child: Text(text),
        ),
      ),
    );
  }
}
