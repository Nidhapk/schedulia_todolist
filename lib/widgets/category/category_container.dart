// import 'package:flutter/material.dart';
// import 'package:schedulia/widgets/colors.dart';

// class CategoryContainer extends StatelessWidget {
//   final String iconImage;

//   final String? text;

//   const CategoryContainer({
//     super.key,
//     required this.iconImage,
//     this.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       width: screenWidth * 0.9,
//       height: screenHeight * 0.1,
//       decoration: BoxDecoration(
//         color: white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: darkpurple,
//             offset: const Offset(0.5, 5.0),
//             blurRadius: 3.0,
//             spreadRadius: 1.0,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [Image.asset(iconImage)],
//       ),
//     );
//   }
// }
