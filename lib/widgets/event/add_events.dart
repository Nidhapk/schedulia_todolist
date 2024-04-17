// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/db_functions/event_db_functions.dart';
import 'package:schedulia/model/event/event_model.dart';
import 'package:schedulia/screens/home_screen/home_screen.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/custom_snackbar.dart';
import 'package:schedulia/widgets/event/event_button.dart';
import 'package:schedulia/widgets/textfield/custom_task_textformfield.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddEvents> {
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventdescriptionController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  File? imagepath;
  String? image;
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        title: const Text('Add Event'),
        toolbarHeight: 100,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        backgroundColor: appBarColor,
        foregroundColor: white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: white),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          pickImageFromGallery();
                        },
                        child: Stack(children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: imagepath != null
                                ? Image.file(
                                    imagepath!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'lib/assets/gallery/gallery.jpg',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          if (imagepath == null)
                            Positioned(
                                top: 60,
                                child: Icon(
                                  Icons.add,
                                  color: white,
                                  size: 30,
                                ))
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    datePicker();
                                  },
                                  icon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: grey,
                                  )),
                              Text(DateFormat('dd-MMM-yyy')
                                  .format(selectedDate!)),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    timePicker();
                                  },
                                  icon: Icon(
                                    Icons.timer,
                                    color: grey,
                                  )),
                              Text(selectedTime!.format(context)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyCustomTextFormField(
                          maxLines: 1,
                          mode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            final trimmedvalue = value?.trim();
                            if (trimmedvalue == null || trimmedvalue.isEmpty) {
                              return 'title can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          hintText: 'title',
                          customController: eventTitleController),
                      const SizedBox(
                        height: 20,
                      ),
                      MyCustomTextFormField(
                          mode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            final trimmedValue = value?.trim();
                            if (trimmedValue == null || trimmedValue.isEmpty) {
                              return 'description can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          hintText: 'description',
                          customController: eventdescriptionController),
                      const SizedBox(
                        height: 20,
                      ),
                      MyCustomTextFormField(
                          mode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            final trimmedValue = value?.trim();
                            if (trimmedValue == null || trimmedValue.isEmpty) {
                              return 'location can\'t be empty';
                            } else {
                              return null;
                            }
                          },
                          hintText: 'location',
                          customController: eventLocationController),
                      const SizedBox(
                        height: 20,
                      ),
                      EventButton(
                          width: 350,
                          text: 'Add',
                          onPressed: () async {
                            await addButtonOnClicked();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void datePicker() async {
    DateTime? now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  timePicker() async {
    //DateTime? pickedDateTime = selectedDate;
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      if (selectedDate != null &&
          time != null &&
          selectedDate!.hour <= time.hour &&
          selectedDate!.minute <= time.minute) {
        selectedTime = time;
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Invalid Time'),
              content: const Text('Choose a upcomeing time'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      timePicker();
                    },
                    child: const Text('Ok'))
              ],
            );
          },
        );
      }
    });
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;

    setState(
      () {
        imagepath = File(returnedImage.path);
        image = returnedImage.path;
      },
    );
  }

  addButtonOnClicked() async {
    String? currentUserKey = await UserFunctions().getCurrentUserKey();
    if (formKey.currentState!.validate()) {
      EventModel events = EventModel(
        eventTitle: eventTitleController.text.trim(),
        eventDescription: eventdescriptionController.text.trim(),
        eventDate: DateFormat('dd-MMM-yyy').format(selectedDate!),
        eventTime: selectedTime!.format(context),
        eventImage: imagepath?.path,
        userKey: currentUserKey!,
        eventlocation: eventLocationController.text.trim(),
        isImportant: false,
      );
      await EventFunctions().addEvent(events).then((value) =>
          CustomSnackBar.show(
              context, 'new event  has been successfully added'));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to add task. Please try again later.'),
      ));
    }
  }
}
