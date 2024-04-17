import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class IconItem {
  final IconData icon;
  final Color color;

  IconItem({required this.icon, required this.color});
}

List<IconItem> icons = [
  IconItem(icon: Icons.person_2_rounded, color: darkpurple),
  IconItem(icon: Icons.monitor_heart_rounded, color: darkpurple),
  IconItem(icon: Icons.location_on_outlined, color: darkpurple),
  IconItem(icon: Icons.work_rounded, color: darkpurple),
  IconItem(icon: Icons.shopping_cart, color: darkpurple),
  IconItem(icon: Icons.home_work, color: darkpurple),
  IconItem(icon: Icons.cake, color: darkpurple),
  IconItem(icon: Icons.food_bank_rounded, color: darkpurple),
  IconItem(icon: Icons.campaign_sharp, color: darkpurple),
  IconItem(icon: Icons.card_giftcard_rounded, color: darkpurple),
  IconItem(icon: Icons.play_circle_fill_outlined, color: darkpurple),
  IconItem(icon: Icons.time_to_leave_sharp, color: darkpurple),
  IconItem(icon: Icons.punch_clock_sharp, color: darkpurple),
];
