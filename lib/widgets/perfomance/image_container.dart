import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class ImageContainer extends StatelessWidget {
  final bool condition;
  final ImageProvider<Object> imageProvider;
  const ImageContainer(
      {super.key, required this.condition, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: grey,
            width: 2.0,
          ),
        ),
        child: condition
            ? CircleAvatar(backgroundImage: imageProvider)
            : const CircleAvatar(
                backgroundImage:
                    AssetImage('lib/assets/profile/profile_icon.jpg')));
  }
}
