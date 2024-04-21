import 'package:flutter/material.dart';
import 'package:schedulia/db_functions/task_db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/event/eventview_rows.dart';

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
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          EventViewRow(
                              title: 'Task title',
                              body: taskIndex.taskTitle ?? ''),
                          Divider(
                            thickness: 1,
                            color: lightGrey,
                          ),
                          taskIndex.taskType != null &&
                                  taskIndex.taskType!.isNotEmpty
                              ? EventViewRow(
                                  title: 'Task Type',
                                  body: taskIndex.taskType ?? '')
                              : const SizedBox(),
                          taskIndex.taskType != null &&
                                  taskIndex.taskType!.isNotEmpty
                              ? Divider(
                                  thickness: 1,
                                  color: lightGrey,
                                )
                              : const SizedBox(),
                          EventViewRow(
                              title: 'Date', body: taskIndex.date ?? ''),
                          Divider(
                            thickness: 1,
                            color: lightGrey,
                          ),
                          EventViewRow(
                              title: 'Start Time',
                              body: taskIndex.startTime ?? ''),
                          Divider(
                            thickness: 1,
                            color: lightGrey,
                          ),
                          EventViewRow(
                              title: 'End Time', body: taskIndex.endTime ?? ''),
                          Divider(
                            thickness: 1,
                            color: lightGrey,
                          ),
                          taskIndex.taskNote != null &&
                                  taskIndex.taskNote!.isNotEmpty
                              ? const EventViewRow(title: 'Task Note', body: '')
                              : const SizedBox(),
                          taskIndex.taskNote != null &&
                                  taskIndex.taskNote!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 20, right: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: lightGrey),
                                        gradient: LinearGradient(colors: [
                                          viewContainerColorOne,
                                          viewContainerColorTwo
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(taskIndex.taskNote ?? ''),
                                    ),
                                  ),
                                )
                              : const SizedBox()
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
