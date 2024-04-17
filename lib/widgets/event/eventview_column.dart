import 'package:flutter/material.dart';
import 'package:schedulia/class/custom_textstyle.dart';

class EventViewcolumn extends StatelessWidget {
  final String title;
  final String body;
  const EventViewcolumn({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: MyTextStyle.eventHeadingStyle),
          const SizedBox(
            height: 10,
          ),
          Text(body, style: MyTextStyle.eventBodystyle)
        ],
      ),
    );
  }
}
