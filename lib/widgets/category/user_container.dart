import 'dart:io';
import 'package:flutter/material.dart';
import 'package:schedulia/class/menu_items.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/popup/custom_popup.dart';

class UserContainer extends StatelessWidget {
  final String text;
  final String img;
  final List<MenuItem> items;
  final Color color;

  const UserContainer(
      {super.key,
      required this.text,
      required this.img,
     required  this.items,required this.color});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.only(
            top: width < 600 ? height * 0.036 : 0.05,
            left: width < 600 ? width * 0.03 : width * 0.05,
            right: width < 600 ? width * 0.03 : width * 0.05),
        child: Container(
            decoration: BoxDecoration(
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
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      SizedBox(
                        height: height * 0.04,width:width* 0.35,
                      ),
                        CustomPopUpButton(items: items, color: color)
                    ],
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
                                backgroundImage: AssetImage(
                                    'lib/assets/profile/profile_icon.jpg'),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(File(img)),
                              ),
                      ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  SizedBox(
                    width: width * 0.7,
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
                  SizedBox(
                    height: height * 0.04,
                  )
                ],
              ),
            )));
  }
}
