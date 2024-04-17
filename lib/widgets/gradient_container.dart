import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class RadientContainer extends StatelessWidget {
  final Widget? widget;
  const RadientContainer({super.key, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, gradientPink],
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
      ),
      child: widget,
    );
  }
}
