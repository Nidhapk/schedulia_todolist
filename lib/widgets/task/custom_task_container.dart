import 'package:flutter/material.dart';

class CustomTaskContainer extends StatelessWidget {
  final String text;
  final List<Color> colors;
  final VoidCallback onTap;
  final String startTime;
  final String endTime;
  final Widget? widget;
  final BoxBorder? border;
  final TextDecoration? decoration;
  const CustomTaskContainer(
      {super.key,
      required this.text,
      required this.onTap,
      required this.colors,
      required this.startTime,
      required this.endTime,
      this.decoration,
      this.border,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 70,
          decoration: BoxDecoration(
            border: border,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                )
              ],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                colors: colors,

                // Color.fromARGB(255, 252, 219, 205),
                // Color.fromARGB(255, 232, 203, 249),
              )),
          child: ListTile(
            onTap: onTap,
            title: Text(
              text,
              style:  TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  decoration: decoration),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: widget,
            subtitle: Text(
              '$startTime to $endTime',
              style: const TextStyle(fontSize: 12),
            ),
          )),
    );
  }
}
