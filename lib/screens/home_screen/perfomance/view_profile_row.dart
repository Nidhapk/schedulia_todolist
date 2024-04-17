import 'package:flutter/material.dart';
import 'package:schedulia/class/custom_textstyle.dart';

class ViewprofileRow extends StatelessWidget {
  final IconData icon;
  final String text;
 final  VoidCallback onTap;
  const ViewprofileRow({super.key, required this.icon, required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon),
        const     SizedBox(
              width: 30,
            ),
            Text(text, style: MyTextStyle.viewProfileStyle)
          ],
        ),
      ),
    );
  }
}
