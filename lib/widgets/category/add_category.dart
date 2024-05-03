import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height:width< 600?height*0.1:100,
      width:width<600? width*0.1:width*0.07,
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
