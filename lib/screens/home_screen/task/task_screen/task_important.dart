import 'package:flutter/material.dart';
import 'package:schedulia/db_functions/task_db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/screens/home_screen/task/task_view_screen.dart';
import 'package:schedulia/widgets/event/empty_event.dart';
import 'package:schedulia/widgets/task/custom_task_container.dart';

// ignore: must_be_immutable
class TaskImportant extends StatelessWidget {
  const TaskImportant({super.key});

  @override
  Widget build(BuildContext context) {
    TaskFunctions().getTaskImportant();
    return ValueListenableBuilder(
      valueListenable: taskImportantNotifier,
      builder: ((BuildContext context, List<TaskModel> taskDoneList, child_) {
        if (taskDoneList.isNotEmpty) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return CustomTaskContainer(
                colors: [
                  Color.fromARGB(255, 252, 219, 205),
                  Color.fromARGB(255, 232, 203, 249),
                ],
                text: taskDoneList[index].taskTitle!,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ViewTask(taskIndex: taskDoneList[index])));
                },
                widget: Text(taskDoneList[index].date ?? ''),
                startTime: taskDoneList[index].startTime ?? '',
                endTime: taskDoneList[index].endTime ?? '',
              );
            },
            itemCount: taskDoneList.length,
          );
        } else {
          return const Padding(
            padding: EdgeInsets.only(top: 150.0),
            child: EmptyEvent(text: 'No important task has been marked'),
          );
        }
      }),
    );
  }
}
