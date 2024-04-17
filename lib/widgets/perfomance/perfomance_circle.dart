import 'package:flutter/material.dart';
class PerfomanceCircle extends StatelessWidget {
  final String image;
  final String text1;
  final String text2;
  final Widget? sizedBox;
  const PerfomanceCircle(
      {super.key,
      required this.text1,
      required this.text2,
      required this.image,
      this.sizedBox});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
            ),
            child: Text(
              text1,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            )),
        // PerfomanceSB(),
        // Text(
        //   text1,
        //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        // )

        Row(
          children: [
           Container(
              height: 15,
              width: 15,
              child: Image.asset(image),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text2,
              style: TextStyle(fontSize: 15),
            ),
          ],
        )
      ],
    );
  }
}
