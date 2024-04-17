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
    // TODO: implement initState

    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Tasks',
                style: TextStyle(color: white, fontSize: 25),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 151, 145, 153),
                    borderRadius: BorderRadius.circular(8)),
                child: TabBar(
                  dividerHeight: 0,
                  indicatorColor: darkpurple,
                  indicatorPadding: EdgeInsets.all(5),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: white),
                  controller: controller,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
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

              // SizedBox(
              //   height: 20,
              // )

              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [TaskDone(), TaskNotDone(), TaskImportant()],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
