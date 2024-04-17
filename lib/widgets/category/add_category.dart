import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 178,
      width: 178,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        dashPattern: const [10.0, 10.0],
        color: Colors.grey,
        strokeWidth: 2,
        child: Center(
          child: Text(
            '+ Add Category ',
            style: TextStyle(fontWeight: FontWeight.w600, color: grey),
          ),
        ),
      ),
    );
  }
}
