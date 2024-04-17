import 'package:flutter/material.dart';
import 'package:schedulia/screens/home_screen/perfomance/view_profile_row.dart';
import 'package:schedulia/widgets/colors.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200, 
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 216, 219, 250),
            Color.fromARGB(255, 229, 217, 250),
          ]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ViewprofileRow(
              icon: Icons.list_alt_sharp,
              text: 'Add Task',
              onTap: () {
                Navigator.of(context).pushNamed('/addTask');
              }),
          Divider(
            thickness: 1,
            color: grey,
          ),
          ViewprofileRow(
              icon: Icons.event_note,
              text: 'Add Event',
              onTap: () {
                Navigator.of(context).pushNamed('/addEvent');
              }),
        ],
      ),
    );
  }
}
