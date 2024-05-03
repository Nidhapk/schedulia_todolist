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
    final width = MediaQuery.of(context).size.width;
    return

      // width: width,
      ElevatedButton(
        style: ButtonStyle(
  fixedSize: MaterialStatePropertyAll(Size(width, 50)),
          backgroundColor: MaterialStatePropertyAll(appBarColor),
          foregroundColor: MaterialStatePropertyAll(white),
        ),
        onPressed: onpressed,
          child: Text(text),
    
    );
  }
}
