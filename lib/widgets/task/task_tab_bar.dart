import 'package:flutter/material.dart';
import 'package:schedulia/screens/home_screen/task/task_screen/task_done.dart';
import 'package:schedulia/screens/home_screen/task/task_screen/task_important.dart';
import 'package:schedulia/screens/home_screen/task/task_screen/task_not_done.dart';
import 'package:schedulia/widgets/colors.dart';

class TaskTabBar extends StatefulWidget {
  const TaskTabBar({super.key});

  @override
  State<TaskTabBar> createState() => _TaskTabBarState();
}

class _TaskTabBarState extends State<TaskTabBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late TabController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBarColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
             const  SizedBox(
                height: 40,
              ),
              Text(
                'Tasks',
                style: TextStyle(color: white, fontSize: 25),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color:const  Color.fromARGB(255, 151, 145, 153),
                    borderRadius: BorderRadius.circular(8)),
                child: TabBar(
                  dividerHeight: 0,
                  indicatorColor: darkpurple,
                  indicatorPadding: const EdgeInsets.all(5),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: white),
                  controller: controller,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs:const  [
                    Tab(
                      text: 'Done',
                    ),
                    Tab(
                      text: 'Not Done',
                    ),
                    Tab(
                      text: 'Important',
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: const [TaskDone(), TaskNotDone(), TaskImportant()],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
