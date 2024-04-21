import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:schedulia/widgets/colors.dart';

class GradientCircularPercentIndicator extends StatelessWidget {
  final double radius;
  final double percent;

  const GradientCircularPercentIndicator(
      {required this.radius, required this.percent, super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: 15.0,
      percent: percent,
      center: Text(
        "${(percent * 100).toStringAsFixed(0)}%",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: const Color.fromARGB(255, 205, 193, 218),
      progressColor: darkpurple,
    );
  }
}
