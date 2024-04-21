import 'package:flutter/material.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:schedulia/screens/home_screen/category/new_category_home_screen.dart';
import 'package:schedulia/screens/home_screen/event/event_screen.dart';
import 'package:schedulia/screens/home_screen/perfomance/perfomance_screen.dart';
import 'package:schedulia/screens/home_screen/task/task_screen/task_screen.dart';
import 'package:schedulia/widgets/bottom_navigation_bar.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/custom_bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userKey;
  @override
  @override
  Widget build(BuildContext context) {
    final pages = [
      const CategoryScreenNew(),
      const TaskTabBar(),
      //AddNewTask(),
      //CalenderScreen(),
      const EventScreen(),
      const PerfomanceScreen(),
    ];

    ValueNotifier<int> selectedValueNotifier = ValueNotifier<int>(0);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const CustomBottomSheet();
            },
          );
        },
        child: Icon(
          Icons.post_add,
          color: darkpurple,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedValueNotifier,
        builder: (BuildContext context, int updatedIndex, _) {
          return pages[updatedIndex];
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedValueNotifier: selectedValueNotifier,
      ),
    );
  }

  Future<String?> initializeCurrentkey() async {
    return await UserFunctions().getCurrentUserKey();
  }

  Future<UserModel?> loadCurrentUser() async {
    return await UserFunctions().getCurrentUser(userKey!);
  }
}
