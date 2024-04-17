//import 'package:schedulia/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final ValueNotifier<int> selectedValueNotifier;
  const CustomBottomNavBar(
      {super.key, required, required this.selectedValueNotifier});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
              color: const Color.fromARGB(255, 105, 66, 118), width: 2.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          child: ValueListenableBuilder(
            valueListenable: selectedValueNotifier,
            builder: (BuildContext ctx, int updatedIndex, Widget? _) {
              return BottomNavigationBar(
                backgroundColor: appBarColor,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                selectedItemColor: Color.fromARGB(255, 88, 54, 106),
                unselectedItemColor: Color.fromARGB(95, 29, 9, 29),
                currentIndex: selectedValueNotifier.value,
                onTap: (selectedIndex) {
                  selectedValueNotifier.value = selectedIndex;
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.view_list_rounded),
                    label: 'Task',
                  ),
                  
                  BottomNavigationBarItem(
                    icon: Icon(Icons.event_note_rounded),
                    label: 'Events',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_4),
                    label: 'Perfomance',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
