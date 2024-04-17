import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class MyCustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool? enabled;
  final AutovalidateMode? mode;
  final TextEditingController customController;
  final Widget? icon;
  final String? Function(String?)? validator;
  final int? maxLines;
  const MyCustomTextFormField(
      {super.key,
      required this.hintText,
      this.enabled,
      required this.customController,
      this.icon,
      this.validator,
      this.maxLines,
      this.mode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      autovalidateMode: mode,
      maxLines: maxLines,
      controller: customController,
      validator: validator,
      decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: icon,
          ),
          hintText: hintText,
          hintStyle:const  TextStyle(fontSize: 15),
          contentPadding: const EdgeInsets.only(left: 25, top: 15, bottom: 15),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          focusColor: darkpurple,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: darkpurple,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 213, 204, 219),   
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30))),
    );
  }
}

class CustmText extends StatelessWidget {
  final String text;
  const CustmText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
    );
  }
}
