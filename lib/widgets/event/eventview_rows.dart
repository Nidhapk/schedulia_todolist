import 'package:flutter/material.dart';
import 'package:schedulia/class/custom_textstyle.dart';

class EventViewRow extends StatelessWidget {
  final String title;
  final String body;
  const EventViewRow({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: MyTextStyle.eventHeadingStyle,),
          Text(
            body,
            style: MyTextStyle.eventBodystyle,
          )
        ],
      ),
    );
  }
}
