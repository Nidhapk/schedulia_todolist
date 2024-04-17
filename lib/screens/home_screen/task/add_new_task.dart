// ignore_for_file: prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedulia/class/custom_textstyle.dart';
import 'package:schedulia/db_functions/category_db.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/db_functions/task_db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:schedulia/screens/home_screen/home_screen.dart';
import 'package:schedulia/services/notification_services.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/custom_snackbar.dart';
import 'package:schedulia/widgets/textfield/custom_task_textformfield.dart';
import 'package:schedulia/widgets/dropdown.dart';

ValueNotifier<bool> reminderNotifier = ValueNotifier(false);

class AddNewTask extends StatefulWidget {
  AddNewTask({
    super.key,
  });

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    initializeUser().then((user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  late TimeOfDay dateTime = TimeOfDay.now();

  List<String> listcategory = [];
  List<String> emptyList = ['No category added'];

  dynamic selectedValueCategory;

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final taskTypeController = TextEditingController();
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endtimeController = TextEditingController();
  final reminderController = TextEditingController();
  final repeatController = TextEditingController();
  final taskNoteController = TextEditingController();

  bool? reminderOn = false;

  @override
  Widget build(BuildContext context) {
    CategoryFunctions().currentUserCategory(userKey!);
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
                'Add Task',
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
                            mode: AutovalidateMode.onUserInteraction,
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
                                        mode: AutovalidateMode.onUserInteraction,
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
                                            String time = value.trim();
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
                          ),
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
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, bottom: 20),
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
                                    await onAddTaskButtonClicked();
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
                                    'Save',
                                    style: TextStyle(fontSize: 20.0),
                                  )))
                        ],
                      ),
                    )),
                  )),
            ))
          ],
        ));
  }

  Future<void> onAddTaskButtonClicked() async {
    try {
      String? currentUserKey = await UserFunctions().getCurrentUserKey();

      final _taskTitle = titleController.text.trim();
      final _date = dateController.text.trim();
      final _startTime = startTimeController.text.trim();
      final _endTime = endtimeController.text.trim();
      final _taskNote = taskNoteController.text.trim();
      final _taskType = taskTypeController.text.trim();

      if (formKey.currentState!.validate()) {
        TaskModel task = TaskModel(
          taskTitle: _taskTitle,
          date: _date,
          startTime: _startTime,
          endTime: _endTime,
          reminder: reminderOn,
          // repeat: _repeat,
          taskNote: _taskNote,
          taskType: _taskType,
          isImportant: false,
          iscompleted: false,
          userKey: currentUserKey,
        );

        await TaskFunctions().addTask(task);
        CustomSnackBar.show(context, 'new task has been successfully added');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please fill in all required fields'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to add task. Please try again later.'),
      ));
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

bool isValidDateFormat(String value) {
  RegExp dateRegex = RegExp(r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$');
  return dateRegex.hasMatch(value);
}

bool isValidTimeFormat(String value) {
  RegExp timeRegex = RegExp(r'^((1[0-2]|0?[1-9]):([0-5]\d) ([AP]M))$');
  return timeRegex.hasMatch(value);
}

initializeUser() async {
  return await UserFunctions().getCurrentUser(userKey!);
}
