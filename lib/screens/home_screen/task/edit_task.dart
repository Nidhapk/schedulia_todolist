import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:schedulia/class/custom_textstyle.dart';
import 'package:schedulia/db_functions/category_db.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/db_functions/task_db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:schedulia/screens/home_screen/home_screen.dart';
import 'package:schedulia/screens/home_screen/task/add_new_task.dart';
import 'package:schedulia/services/notification_services.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/custom_snackbar.dart';
import 'package:schedulia/widgets/dropdown.dart';
import 'package:schedulia/widgets/textfield/custom_task_textformfield.dart';

// ignore: must_be_immutable
class EditTask extends StatefulWidget {
  TaskModel taskindex;
  int key1;
  EditTask({required this.taskindex, super.key, required this.key1});

  @override
  State<EditTask> createState() => _EditTaskState();
  
}
class _EditTaskState extends State<EditTask> {
  late TimeOfDay dateTime = TimeOfDay.now();
  UserModel? currentUser;

  dynamic selectedValueCategory;

  final formKey = GlobalKey<FormState>();

  List<String> listcategory = [];
  List<String> emptyList = ['No category added'];

  final titleController = TextEditingController();
  final taskTypeController = TextEditingController();
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endtimeController = TextEditingController();
  final taskNoteController = TextEditingController();
  bool? reminderOn;
  ValueNotifier<bool> reminderNotifier2 = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskindex.taskTitle ?? '';
    taskTypeController.text = widget.taskindex.taskType ?? '';
    dateController.text = widget.taskindex.date ?? '';
    startTimeController.text = widget.taskindex.startTime ?? '';
    endtimeController.text = widget.taskindex.endTime ?? '';
    taskNoteController.text = widget.taskindex.taskNote ?? '';
    reminderOn = widget.taskindex.reminder;

    initializeUser().then((user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              pinned: true,
              title: Text(
                'Edit Task',
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
              child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SingleChildScrollView(
                        child: Padding(
                      padding:  EdgeInsets.only(left:  width < 600 ? width * 0.04 : width * 0.3, right:  width < 600 ? width * 0.04 : width * 0.3,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child: Text('Task Title',
                                style: MyTextStyle.taskFieldStyle),
                          ),
                          MyCustomTextFormField(
                            mode: AutovalidateMode.onUserInteraction,
                            hintText: 'Enter your title here',
                            customController: titleController,
                            validator: (value) {
                              final trimmedValue = value?.trim();
                              if (trimmedValue == null ||
                                  trimmedValue.isEmpty) {
                                return 'Title Can\'t be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child: Text('Category',
                                style: MyTextStyle.taskFieldStyle),
                          ),
                          ValueListenableBuilder(
                            valueListenable: currentUserCategoryNotifier,
                            builder: (context, value, child) {
                              if (value.isEmpty) {
                                return CustomDropdownButton(
                                    onChanged: (value) {}, items: emptyList);
                              } else {
                                listcategory.clear();
                                for (var element in value) {
                                  listcategory.add(element.categoryTitle);
                                }
                                selectedValueCategory ??= listcategory.first;

                                return CustomDropdownButton(
                                    controller: taskTypeController,
                                    selectedValue: selectedValueCategory,
                                    onChanged: (dynamic newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          selectedValueCategory = newValue;
                                          taskTypeController.text =
                                              selectedValueCategory;
                                        });
                                      }
                                    },
                                    items: listcategory);
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child:
                                Text('Date', style: MyTextStyle.taskFieldStyle),
                          ),
                          MyCustomTextFormField(
                            customController: dateController,
                            maxLines: 1,
                            mode: AutovalidateMode.always,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'date can\'t be empty';
                              } else if (!isValidDateFormat(
                                  dateController.text.trim())) {
                                return 'Please enter a valid date format';
                              } else {
                                DateTime? selectedDate = DateTime.tryParse(
                                    dateController.text.trim());
                                if (selectedDate != null &&
                                    selectedDate.isBefore(DateTime.now()
                                        .subtract(const Duration(days: 1)))) {
                                  return 'Choose an upcoming date or todays date';
                                }
                                return null;
                              }
                            },
                            hintText: 'Choose date',
                            icon: IconButton(
                              onPressed: () {
                                datePicker();
                              },
                              icon: const Icon(
                                Icons.calendar_today_rounded,
                                size: 18,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 10, bottom: 10),
                                      child: Text('Start Time',
                                          style: MyTextStyle.taskFieldStyle),
                                    ),
                                    MyCustomTextFormField(
                                        maxLines: 1,
                                        customController: startTimeController,
                                        //width: 150,
                                        hintText: 'Choose time',
                                        mode: AutovalidateMode.always,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Set starting time';
                                          } else if (!isValidTimeFormat(
                                              startTimeController.text
                                                  .trim())) {
                                            return 'Please enter a valid time format(HH:mm)';
                                          } else {
                                            DateTime? selectedDate =
                                                DateTime.tryParse(
                                                    dateController.text.trim());
                                            DateTime today = DateTime.now();
                                            DateTime todayWithoutTime =
                                                DateTime(today.year,
                                                    today.month, today.day);
                                            String time =
                                                startTimeController.text.trim();
                                            List parts = time.split(' ');
                                            List timeParts =
                                                parts[0].split(':');
                                            int hour = int.parse(timeParts[0]);
                                            int minutes =
                                                int.parse(timeParts[1]);
                                            String period =
                                                parts[1]; // AM or PM
                                            if (period == "PM" && hour != 12) {
                                              hour += 12;
                                            }
                                            TimeOfDay pickedTime = TimeOfDay(
                                                hour: hour, minute: minutes);
                                            if (selectedDate != null &&
                                                selectedDate.isAtSameMomentAs(
                                                    todayWithoutTime) &&
                                                pickedTime.hour <=
                                                    DateTime.now()
                                                        .toLocal()
                                                        .hour &&
                                                pickedTime.minute <=
                                                    DateTime.now()
                                                        .toLocal()
                                                        .minute) {
                                              return 'Choose an upcoming \ntime';
                                            }
                                            return null;
                                          }
                                        },
                                        icon: IconButton(
                                          onPressed: () async {
                                            await timePicker();
                                          },
                                          icon: const Icon(
                                            Icons.watch_later_outlined,
                                            size: 20,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              //
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 10, bottom: 10),
                                      child: Text('End Time',
                                          style: MyTextStyle.taskFieldStyle),
                                    ),
                                    MyCustomTextFormField(
                                        maxLines: 1,
                                        enabled: true,
                                        customController: endtimeController,
                                        mode:
                                            AutovalidateMode.onUserInteraction,
                                        // width: 150,
                                        hintText: 'Choose time',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please pick \nend time';
                                          }
                                          if (!isValidTimeFormat(value)) {
                                            return 'Please enter a valid \ntime format (HH:mm)';
                                          } else {
                                            String startTimeString =
                                                startTimeController.text.trim();
                                            List startTimeParts =
                                                startTimeString.split(' ');
                                            List startTimeValues =
                                                startTimeParts[0].split(':');
                                            int startHour =
                                                int.parse(startTimeValues[0]);
                                            int startMinute =
                                                int.parse(startTimeValues[1]);
                                            String startPeriod =
                                                startTimeParts[1]; // AM or PM
                                            if (startPeriod == "PM" &&
                                                startHour != 12) {
                                              startHour += 12;
                                            }

                                            String endTimeString =
                                                endtimeController.text.trim();
                                            List endTimeParts =
                                                endTimeString.split(' ');
                                            List endTimeValues =
                                                endTimeParts[0].split(':');
                                            int endHour =
                                                int.parse(endTimeValues[0]);
                                            int endMinute =
                                                int.parse(endTimeValues[1]);
                                            String endPeriod =
                                                endTimeParts[1]; // AM or PM
                                            if (endPeriod == "PM" &&
                                                endHour != 12) {
                                              endHour += 12;
                                            }

                                            // Convert start and end times to TimeOfDay objects
                                            TimeOfDay startTime = TimeOfDay(
                                                hour: startHour,
                                                minute: startMinute);
                                            TimeOfDay endTime = TimeOfDay(
                                                hour: endHour,
                                                minute: endMinute);

                                            // Compare start and end times
                                            if (startTime.hour > endTime.hour ||
                                                (startTime.hour ==
                                                        endTime.hour &&
                                                    startTime.minute >=
                                                        endTime.minute)) {
                                              return 'End time should be \nafter start time';
                                            }
                                            return null;
                                          }
                                        },
                                        icon: IconButton(
                                          onPressed: () async {
                                            timePickerEnd();
                                          },
                                          icon: const Icon(
                                            Icons.watch_later_outlined,
                                            size: 20,
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10),
                            child: Text('Task Note',
                                style: MyTextStyle.taskFieldStyle),
                          ),
                          MyCustomTextFormField(
                            hintText: 'Enter discription here',
                            customController: taskNoteController,
                            maxLines: 5,
                          ),!kIsWeb?
                          ValueListenableBuilder(
                            valueListenable: reminderNotifier,
                            builder: (context, value, child) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, bottom: 10),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      reminderNotifier.value =
                                          !reminderNotifier.value;
                                      reminderOn = !reminderOn!;
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: BorderSide(
                                                    color: reminderOn == true
                                                        ? appBarColor
                                                        : Colors.black,
                                                    width: 1))),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                reminderOn == true
                                                    ? appBarColor
                                                    : white)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              reminderOn == true
                                                  ? 'Reminder is On'
                                                  : 'Set Reminder',
                                              style: TextStyle(
                                                  color: reminderOn == true
                                                      ? white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Icon(
                                            reminderOn == true
                                                ? Icons.notifications_active
                                                : Icons.notifications_none,
                                            color: reminderOn == true
                                                ? white
                                                : Colors.black,
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
                          ):const SizedBox(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, bottom: 20),
                              child: SizedBox( width: width < 600 ? width * 0.96 : width * 0.8,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (reminderOn == true) {
                                        DateTime pickedDate = DateTime.parse(
                                            dateController.text.trim());
                                        String time =
                                            startTimeController.text.trim();
                                        List parts = time.split(' ');
                                        List timeParts = parts[0].split(':');
                                        int hour = int.parse(timeParts[0]);
                                        int minutes = int.parse(timeParts[1]);
                                        String period = parts[1]; // AM or PM
                                        if (period == "PM" && hour != 12) {
                                          hour += 12;
                                        }
                                        TimeOfDay pickedTime = TimeOfDay(
                                            hour: hour, minute: minutes);
                                        await LocalNotificationService
                                            .showScheduledNotification(
                                                time: pickedTime,
                                                date: pickedDate,
                                                title:
                                                    'Hey ${currentUser?.userName ?? 'there'}, Don\'t forget about your task.',
                                                body:
                                                    'Title : ${titleController.text.trim()}\nGet it done now!');
                                      }
                                      await updateTask(
                                        widget.key1,
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        appBarColor,
                                      ),
                                      foregroundColor:
                                          MaterialStatePropertyAll(white),
                                      fixedSize: const MaterialStatePropertyAll(
                                        Size(380.0, 50.0),
                                      ),
                                    ),
                                    child: const Text(
                                      'Edit',
                                      style: TextStyle(fontSize: 20.0),
                                    )),
                              ))
                        ],
                      ),
                    )),
                  )),
            ))
          ],
        ));
  }

  Future updateTask(int key1) async {
    final Box<TaskModel> tasks = await Hive.openBox<TaskModel>('task_db');
    final TaskModel existingTask = tasks.get(key1)!;
    final taskTitle = titleController.text.trim();
    final date = dateController.text.trim();
    final startTime = startTimeController.text.trim();
    final endTime = endtimeController.text.trim();
    final taskNote = taskNoteController.text.trim();
    final taskType = taskTypeController.text.trim();

    if (formKey.currentState!.validate()) {
      TaskModel taskModel = TaskModel(
          taskTitle: taskTitle,
          date: date,
          startTime: startTime,
          endTime: endTime,
          taskNote: taskNote,
          taskType: taskType,
          isImportant: existingTask.isImportant,
          iscompleted: existingTask.iscompleted,
          userKey: userKey,
          reminder: reminderOn);

      await TaskFunctions()
          .editTask(taskModel, key1)
          .then((value) => Navigator.of(context).pop());
      // ignore: use_build_context_synchronously
      CustomSnackBar.show(context, 'Task has been edited successfully');
    } else {
      return null;
    }
  }

  void datePicker() async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (pickDate != null) {
      setState(() {
        dateController.text = DateFormat('yyy-MM-dd').format(pickDate);
      });
    }
  }

  timePicker() async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      startTimeController.text = time!.format(context);
    });
  }

  timePickerEnd() async {
    TimeOfDay? endTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      endtimeController.text = endTime!.format(context);
    });
  }
}
