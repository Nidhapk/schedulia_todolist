import 'package:flutter/material.dart';

class ProfileEB extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const ProfileEB({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return SizedBox(
        width: width<600?width*0.79:width*0.39,
        height: height*0.06,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          ),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          backgroundColor: const MaterialStatePropertyAll(
            Color.fromARGB(255, 59, 56, 63),
          ),
        ),
          child: Text(text),
          
        ),
  
    );
  }
}
