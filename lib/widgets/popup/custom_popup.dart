import 'package:flutter/material.dart';
import 'package:schedulia/class/menu_items.dart';
import 'package:schedulia/widgets/colors.dart';

class CustomPopUpButton extends StatelessWidget {
  final Color color;
  final List<MenuItem> items;
  const CustomPopUpButton(
      {super.key, required this.items, required this.color});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return PopupMenuButton<MenuItem>(
        iconSize: width > 600 ? height * 0.05 : height * 0.035,
        iconColor: color,
        onSelected: (selectedItem) {
          selectedItem.onTap();
        },
        itemBuilder: (BuildContext context) {
          return items.map((MenuItem item) {
            return PopupMenuItem<MenuItem>(
              value: item,
              child: Row(
                children: <Widget>[
                  Icon(
                    item.icon,
                    color: darkpurple,
                  ),
                  const SizedBox(width: 20),
                  Text(item.title),
                ],
              ),
            );
          }).toList();
        });
  }
}
