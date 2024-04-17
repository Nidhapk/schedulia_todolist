import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class NewCustomContainer extends StatelessWidget {
  final Widget child;
  const NewCustomContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [gradientColor1, gradientColor2, white],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: child,
    );
  }
}
