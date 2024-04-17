import 'dart:io';
import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class UserContainer extends StatelessWidget {
  //final UserModel userModel;
  final String text;
  final String img;

  const UserContainer({
    super.key,
    //required this.userModel,
    required this.text,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 35, left: 10, right: 10),
        child: Container(
          height: 200.0,
          decoration: BoxDecoration(
            //color: Color.fromARGB(255, 59, 56, 63),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 110, 100, 117).withOpacity(0.5),
                blurRadius: 7,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              )
            ],
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 48, 46, 56),

              Color.fromARGB(255, 85, 78, 115),
              Color.fromARGB(255, 84, 44, 44)

              //Color.fromARGB(255, 26, 23, 28),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 60.0,
            ),
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: grey,
                  width: 1.0,
                ),
              ),
              child: img == ''
                  ? const CircleAvatar(
                      backgroundImage:
                          AssetImage('lib/assets/profile/profile_icon.jpg'),
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(File(img)),
                    ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 300,
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
