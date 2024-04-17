import 'package:flutter/material.dart';
import 'package:schedulia/db_functions/task_db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/view_task/view_task_text.dart';

class ViewTask extends StatelessWidget {
  final TaskModel taskIndex;
  const ViewTask({super.key, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBarColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: appBarColor,
              foregroundColor: white,
              expandedHeight: 100.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              pinned: true,
              title: Text(
                'View Task',
                style: TextStyle(
                    color: white, fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: ValueListenableBuilder(
                    valueListenable: taskNotifier,
                    builder: (BuildContext context, List<TaskModel> taskList,
                        child_) {
                      return Column(
                        children: [
                          Tasktext(
                            taskTitle: 'Task Title    :',
                            details: taskIndex.taskTitle!,
                          ),
                          taskIndex.taskType != null &&
                                  taskIndex.taskType!.isNotEmpty
                              ? Tasktext(
                                  taskTitle: 'Task Type    :',
                                  details: taskIndex.taskType!,
                                )
                              : const SizedBox(),
                          Tasktext(
                            taskTitle: 'Date              :',
                            details: taskIndex.date!,
                          ),
                          Tasktext(
                            taskTitle: 'Start Time    :',
                            details: taskIndex.startTime!,
                          ),
                          Tasktext(
                            taskTitle: 'End Time      :',
                            details: taskIndex.endTime!,
                          ),
                          taskIndex.taskNote != null &&
                                  taskIndex.taskNote!.isNotEmpty
                              ? Tasktext(
                                  taskTitle: 'Task Note     :',
                                  details: taskIndex.taskNote!,
                                )
                              : const SizedBox(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
