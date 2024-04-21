import 'package:flutter/material.dart';

class PerfomanceCircle extends StatelessWidget {
  final String? image;
  final String text1;
  final String text2;
  final Widget? sizedBox;
  final IconData icon;
  final Color color;
  const PerfomanceCircle(
      {super.key,
      required this.text1,
      required this.text2,
      this.image,
      this.sizedBox,
      required this.icon,required this.color});

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
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            )),
        // PerfomanceSB(),
        // Text(
        //   text1,
        //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        // )

        Row(
          children: [
            //SizedBox(height: 15, width: 15, child:
            Icon(icon,color:color ,),
            // Image.asset(image),
            //),
            const SizedBox(
              width: 10,
            ),
            Text(
              text2,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        )
      ],
    );
  }
}
