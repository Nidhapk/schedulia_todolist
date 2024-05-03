import 'package:flutter/material.dart';
import 'package:schedulia/screens/home_screen/calender/calender_screen.dart';
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
    controller = TabController(length: 4, vsync: this);
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 15,
        backgroundColor: white,
      ),
      body: Container(
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 151, 145, 153),
                    borderRadius: BorderRadius.circular(8)),
                child: TabBar(
                  dividerHeight: 0,
                  indicatorColor: darkpurple,
                  indicatorPadding: const EdgeInsets.all(5),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: white),
                  controller: controller,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(
                      child: Text(
                        'All',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Not Done',
                        style: TextStyle(fontSize: 13),
                      ),
                      //text: 'Not Done',
                    ),
                    Tab(
                      child: Text(
                        'Important',
                        style: TextStyle(fontSize: 13),
                      ),
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
                  children: const [
                    CalenderScreen(),
                    TaskDone(),
                    TaskNotDone(),
                    TaskImportant()
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
