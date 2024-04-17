import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class MyTextStyle {
 Color? color;
  static const TextStyle eventHeadingStyle =
      TextStyle(fontWeight: FontWeight.w700);
  static const TextStyle eventBodystyle =
      TextStyle(fontWeight: FontWeight.w300);
  static const TextStyle namestyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
  static const TextStyle viewProfileStyle = TextStyle(fontSize: 15);
  static TextStyle settingStyle =
      TextStyle(color: grey, fontWeight: FontWeight.w500, fontSize: 15);
  static const TextStyle appNameStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.w500);
  static const TextStyle privacypolicyStyle =
      TextStyle(fontSize: 35, fontWeight: FontWeight.w600);
  static const TextStyle privacypolicyHeadingStyle =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 25);
  static const TextStyle privacypolicybodyStyle =
      TextStyle(fontWeight: FontWeight.w300, fontSize: 15);
  static const TextStyle aboutBodyStyle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 15);
  static const TextStyle userFeedbackStyle =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 13);
   TextStyle timeLineStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: darkpurple);
  static TextStyle taskFieldStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
