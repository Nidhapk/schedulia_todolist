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
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: TextFormField(
        autovalidateMode: mode,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.only(left: 30.0),
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
