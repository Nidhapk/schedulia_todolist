import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyEvent extends StatelessWidget {
  final String text;
  const EmptyEvent({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 20),
          child: SvgPicture.asset(
            'lib/assets/calender/undraw_happy_music_g6wc (1).svg',
            height: 100,
            width: 100,
          ),
        ),
         Text(
          text,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
