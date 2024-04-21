import 'package:flutter/material.dart';
import 'package:schedulia/db_functions/task_db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/screens/home_screen/task/task_view_screen.dart';
import 'package:schedulia/widgets/event/empty_event.dart';
import 'package:schedulia/widgets/task/custom_task_container.dart';

ValueNotifier<List<TaskModel>> taskNotDoneNotifier = ValueNotifier([]);

// ignore: must_be_immutable
class TaskNotDone extends StatelessWidget {
  const TaskNotDone({super.key});

  @override
  Widget build(BuildContext context) {
    TaskFunctions().getTaskNotDone();
    return ValueListenableBuilder(
      valueListenable: taskNotDoneNotifier,
      builder: (context, List<TaskModel> taskNotDonelist, child_) {
        if (taskNotDonelist.isNotEmpty) {
          return ListView.builder(
              itemCount: taskNotDonelist.length,
              itemBuilder: (context, index) {
                return CustomTaskContainer(
                  colors:const  [Color.fromARGB(255, 252, 219, 205),
                      Color.fromARGB(255, 232, 203, 249),],
                  text: taskNotDonelist[index].taskTitle!,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ViewTask(taskIndex: taskNotDonelist[index])));
                  },
                  widget: Text(taskNotDonelist[index].date ?? ''),
                  startTime: taskNotDonelist[index].startTime ?? '',
                  endTime: taskNotDonelist[index].endTime ?? '',
                );
              });
        } else {
          return const  Padding(
            padding: EdgeInsets.only(top: 150.0),
            child: EmptyEvent(
                text: 'There is no task to do!\nYou have done everything'),
          );
        }
      },
    );
  }
}
