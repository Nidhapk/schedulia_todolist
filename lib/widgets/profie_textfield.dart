import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String hintText;
  final AutovalidateMode? mode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const ProfileTextField(
      {super.key,
      required this.hintText,
      this.controller,
      this.validator,
      this.mode});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.only(top: height*0.05, left:width<600?width*0.1:width*0.3, right: width<600?width*0.1:width*0.3),
      child: TextFormField(
        autovalidateMode: mode,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:  EdgeInsets.only(left: width*0.05),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
