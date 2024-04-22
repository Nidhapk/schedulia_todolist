// ignore_for_file: await_only_futures, must_be_immutable
import 'package:flutter/material.dart';
import 'package:schedulia/db_functions/category_db.dart';
import 'package:schedulia/db_functions/task_db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/screens/home_screen/task/edit_task.dart';
import 'package:schedulia/screens/home_screen/task/task_view_screen.dart';
import 'package:schedulia/widgets/alert_box/alert_box.dart';
import 'package:schedulia/widgets/category/custom_calender.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/event/empty_event.dart';
import 'package:schedulia/widgets/time_line/new_custom_timeline.dart';
import 'package:table_calendar/table_calendar.dart';

ValueNotifier<List<TaskModel>> filteredCategoryNotifier = ValueNotifier([]);

class Viewcategory extends StatefulWidget {
  // TaskModel taskModel;

  final int? taskKey;
  String category;
  Viewcategory({
    super.key,
    //required this.taskModel,
    this.taskKey,
    required this.category,
  });

  @override
  State<Viewcategory> createState() => _ViewcategoryState();
}

class _ViewcategoryState extends State<Viewcategory> {
  DateTime todayy = DateTime.now();
  bool showFullText = false;

  @override
  void initState() {
    super.initState();
    initializeTask();
  }

  @override
  Widget build(BuildContext context) {
    initializeTask();
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        foregroundColor: white,
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: GestureDetector(
          onTap: () {
            setState(() {
              showFullText = !showFullText;
            });
          },
          child: Text(
            widget.category,
            style: TextStyle(
                color: white, fontWeight: FontWeight.w600, fontSize: 20.0),
            overflow: showFullText == true ? null : TextOverflow.ellipsis,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: white),
        child: Column(
          children: [
            CategoryTablecalender(
              onDayselected: (DateTime dayy, DateTime focusedDay) async {
                setState(() {
                  todayy = dayy;
                });
                await CategoryFunctions().filterTaskByCategoryOnThisDay(dayy);
              },
              fun: (dayy) => isSameDay(todayy, dayy),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: filterTaskByCategoryOnThisDayNotifier,
                builder: (context, valueList, child) {
                  initializeTask();
                  if (valueList.isEmpty) {
                    return const Center(
                      child: EmptyEvent(text: 'No task has been Scheduled'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: valueList.length,
                      itemBuilder: (context, index) {
                        var keyValue = valueList[index].key;

                        TaskModel modelValue = valueList[index];
                        bool valueChecked1 =
                            valueList[index].iscompleted ?? false;
                        bool valueChecked2 =
                            valueList[index].isImportant ?? false;
                        ValueNotifier checknotifier =
                            ValueNotifier(valueChecked1);
                        ValueNotifier checknotifier2 =
                            ValueNotifier(valueChecked2);

                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: NewCustomTimeLine(
                              subtitleDecoration: valueChecked1 == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              border: valueChecked2 == true
                                  ? Border.all(
                                      width: 1,
                                      color: const Color.fromARGB(
                                          255, 114, 97, 222))
                                  : null,
                              colors: valueChecked2 == true
                                  ? [
                                      const Color.fromARGB(255, 236, 228, 252),
                                      const Color.fromARGB(255, 199, 199, 234)
                                    ]
                                  : [
                                      const Color.fromARGB(255, 252, 219, 205),
                                      const Color.fromARGB(255, 232, 203, 249),
                                    ],
                              lineColor: valueChecked2 == true
                                  ? const Color.fromARGB(255, 191, 191, 252)
                                  : const Color.fromARGB(255, 210, 187, 221),
                              indicatorColor: valueChecked2 == true
                                  ? const Color.fromARGB(255, 139, 139, 243)
                                  : const Color.fromARGB(255, 154, 124, 199),
                              textColor: valueChecked2 == true
                                  ? const Color.fromARGB(255, 81, 56, 240)
                                  : darkpurple,
                              onPressed1: (value) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomAlertBox(
                                        okText: 'delete',
                                        title: 'Delete Task?',
                                        text:
                                            'Are you sure you want to delete this task?',
                                        onpressedCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        onpressedDelete: () async {
                                          await TaskFunctions()
                                              .delete(valueList[index].key!)
                                              .then((value) =>
                                                  Navigator.of(context).pop());
                                        });
                                  },
                                );
                              },
                              onPressed2: (value) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => EditTask(
                                              taskindex: valueList[index],
                                              key1: valueList[index].key,
                                            )))
                                    .then((value) async {
                                  await TaskFunctions().getAllTask();
                                  await initializeTask();
                                  filterTaskByCategoryOnThisDayNotifier
                                      .notifyListeners();
                                });
                                //editTask(valueList[index], valueList[index].key);
                              },
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ViewTask(taskIndex: valueList[index])));
                              },
                              onItem1: () async {
                                valueChecked1 = !valueChecked1!;
                                checknotifier.value = valueChecked1;
                                print('onitem1');

                                await taskDone(
                                    modelValue,
                                    keyValue,
                                    modelValue.taskType!,
                                    valueChecked1,
                                    valueChecked2);
                                await initializeTask();
                              },
                              item1: ValueListenableBuilder(
                                valueListenable: checknotifier,
                                builder: (context, value, child) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text('Mark as Done'),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        modelValue.iscompleted!
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                        size: 20,
                                        color: const Color.fromARGB(
                                            255, 90, 72, 147),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              onItem2: () async {
                                valueChecked2 = !valueChecked2!;
                                checknotifier2.value = valueChecked2;
                                print('onitem2');
                                await taskDone(
                                    modelValue,
                                    keyValue,
                                    modelValue.taskType!,
                                    valueChecked1,
                                    valueChecked2);
                                await initializeTask();
                                print('yes');
                              },
                              item2: ValueListenableBuilder(
                                valueListenable: checknotifier2,
                                builder: (context, value, child) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text('Mark as Important'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        modelValue.isImportant!
                                            ? Icons.star
                                            : Icons.star_border,
                                        size: 24,
                                        color: const Color.fromARGB(
                                            255, 90, 72, 147),
                                      )
                                    ],
                                  );
                                },
                              ),
                              decoration: valueChecked1 == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              title: valueList[index].taskTitle!,
                              startTime: valueList[index].startTime!,
                              endTime: valueList[index].endTime!),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future taskDone(TaskModel task, int key, String category, bool valueChecked1,
      bool valueChecked2) async {
    task.iscompleted = valueChecked1;
    task.isImportant = valueChecked2;
    await TaskFunctions().editTask(task, key);
  }

  Future initializeTask() async {
    await CategoryFunctions().filterTaskByCategory(widget.category);
    await CategoryFunctions().filterTaskByCategoryOnThisDay(todayy);
  }
}
