import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/custom_snackbar.dart';
import 'package:schedulia/widgets/perfomance/image_container.dart';
import 'package:schedulia/widgets/textfield/custom_task_textformfield.dart';
import 'package:schedulia/widgets/gradient_container.dart';
import 'package:schedulia/widgets/profile_iconbutton.dart';

class EditProfile extends StatefulWidget {
  final UserModel? user;
  const EditProfile({super.key, this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController(
      text: userListNotifier.value[keys.indexOf(userKey!)].name);
  final userNameController = TextEditingController(
      text: userListNotifier.value[keys.indexOf(userKey!)].userName);

  final formkey = GlobalKey<FormState>();

  File? imagepath;
  String? image =
      userListNotifier.value[keys.indexOf(userKey!)].userimage ?? '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: RadientContainer(
        widget: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: userListNotifier,
              builder:
                  (BuildContext context, List<UserModel> userlist, child_) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      Stack(
                        children: [
                          ImageContainer(
                              condition: image != null && image!.isNotEmpty,
                              imageProvider: FileImage(File(image!))),
                          ProfileIconButton(onTap: () {
                            pickImageFromGallery();
                          })
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            MyCustomTextFormField(
                              mode: AutovalidateMode.onUserInteraction,
                              hintText: 'Enter your name',
                              maxLines: 1,
                              customController: nameController,
                              // width: 300,
                              validator: (value) {
                                final trimmedValue = value?.trim();
                                if (trimmedValue == null ||
                                    trimmedValue.isEmpty) {
                                  return 'Name can\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyCustomTextFormField(
                              mode: AutovalidateMode.always,
                              hintText: 'Enter your Username', maxLines: 1,
                              customController: userNameController,
                              // width: 300,
                              validator: (value) {
                                final trimmedValue = value?.trim();
                                if (trimmedValue == null ||
                                    trimmedValue.isEmpty) {
                                  return 'Username can\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(appBarColor),
                            foregroundColor: MaterialStatePropertyAll(white)),
                        onPressed: () async {
                          await updateUser()
                              .then((value) => Navigator.of(context).pop());
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 135),
                          child: Text('Edit'),
                        ),
                        // width: 300,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
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

  Future updateUser() async {
    if (formkey.currentState!.validate()) {
      UserModel userModel = UserModel(
        name: nameController.text.trim(),
        userName: userNameController.text.trim(),
        userimage: image,
        password: widget.user?.password,
      );

      await UserFunctions().editUser(userModel, int.parse(userKey!)).then(
          (value) => CustomSnackBar.show(
              context, 'Profile has been successfully edited'));
    }
  }
}
