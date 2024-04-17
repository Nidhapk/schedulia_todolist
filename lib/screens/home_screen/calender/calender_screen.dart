import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedulia/db_functions/task_db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/screens/home_screen/task/edit_task.dart';
import 'package:schedulia/screens/home_screen/task/task_view_screen.dart';
import 'package:schedulia/widgets/alert_box/alert_box.dart';
import 'package:schedulia/widgets/category/custom_calender.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/time_line/time_line.dart';
import 'package:table_calendar/table_calendar.dart';

ValueNotifier<List<TaskModel>> currentUserTasksNotifier = ValueNotifier([]);
ValueNotifier<List<TaskModel>> currentUserTaskOnSelecteDdayNotifier =
    ValueNotifier([]);
DateTime today = DateTime.now();

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({
    super.key,
  });

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTablecalender(
          onDayselected: (DateTime day, DateTime focusedDay) async {
            setState(() {
              today = day;
            });
            await TaskFunctions().getCurrentUsertaskOnSelectedDay(day);
          },
          fun: (day) => isSameDay(today, day),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: currentUserTaskOnSelecteDdayNotifier,
            builder: (BuildContext context, List<TaskModel> taskList, child_) {
              if (taskList.isEmpty) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100, bottom: 20),
                      child: SvgPicture.asset(
                        'lib/assets/calender/undraw_happy_music_g6wc (1).svg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const Text(
                        '      no tasks for the day.\nClick + to create your tasks'),
                  ],
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = taskList[index];
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                              borderRadius: BorderRadius.circular(30),
                              icon: Icons.delete_rounded,
                              foregroundColor: grey,
                              onPressed: (context) async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomAlertBox(
                                        text:
                                            'Are you sure you want to delete this task?',
                                        title: 'Delete Task?',
                                        onpressedCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        onpressedDelete: () async {
                                          await TaskFunctions()
                                              .delete(taskList[index].key!);
                                        });
                                  },
                                );
                              }),
                          SlidableAction(
                              icon: Icons.mode_edit_rounded,
                              foregroundColor: grey,
                              onPressed: (context) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditTask(
                                          taskindex: taskList[index],
                                          key1: taskList[index].key,
                                        )));
                              }),
                        ],
                      ),
                      key: ValueKey(data),
                      child: TimeLine(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewTask(taskIndex: data)));
                        },
                        date: data.date ?? '',
                        taskkey: taskList[index].key ?? UniqueKey().hashCode,
                        taskModel: data,
                        startTime: data.startTime ?? '',
                        endTime: data.endTime ?? '',
                        tasktile: data.taskTitle ?? '',
                      ),
                      // ),
                    );
                  },
                  itemCount: taskList.length,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  initialize() async {
    return await TaskFunctions().getCurrentUsertaskOnSelectedDay(today);
  }
}
