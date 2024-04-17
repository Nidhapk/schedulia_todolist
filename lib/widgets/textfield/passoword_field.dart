import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
 final  AutovalidateMode mode;

  final String hintText;
  const PasswordField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: TextFormField(autovalidateMode: mode,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                const EdgeInsets.only(left: 40, top: 15, bottom: 15),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            focusColor: darkpurple,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: darkpurple, width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
            filled: true,
            fillColor: passowrdlightgrey,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
