// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:schedulia/screens/home_screen/home_screen.dart';
import 'package:schedulia/widgets/profile_button.dart';
import 'package:schedulia/widgets/circleavatar_container.dart';
import 'package:schedulia/widgets/profie_textfield.dart';
import 'package:schedulia/widgets/profile_iconbutton.dart';
import 'package:schedulia/widgets/sizedbox.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final userNameController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  File? imagepath;
  String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 231, 251, 0.91),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Text(
                'Create your profile',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                'Take a step forward to feel\nmore organized',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87, fontSize: 18.0, letterSpacing: 2),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Stack(
                children: [
                  CustomCircleavatar(
                      backgroundImage: imagepath != null
                          ? FileImage(imagepath!)
                          : const AssetImage(
                                  'lib/assets/profile/profile_icon.jpg')
                              as ImageProvider),
                  ProfileIconButton(onTap: () async {
                    await pickImageFromGallery();
                  })
                ],
              ),
              const ProfileSB(),
              Form(
                key: formkey,
                child: Column(
                  children: [
                    ProfileTextField(
                      mode: AutovalidateMode.onUserInteraction,
                      controller: nameController,
                      hintText: 'Enter your name',
                      validator: (value) {
                        final trimmedValue = value?.trim();
                        if (trimmedValue == null || trimmedValue.isEmpty) {
                          return 'Name can\'t be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const ProfileSB(),
                  ],
                ),
              ),
              ProfileEB(
                text: 'Set profile    ',
                onTap: () async {
                  bool data = await registerUser();

                  if (data) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false);
                  }
                },
              ),
              const ProfileSB(),
              ProfileEB(
                text: 'I\'ll do it later',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
              )
            ],
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

  registerUser() async {
    if (formkey.currentState!.validate()) {
      await UserFunctions().addProfile(UserModel(
          name: nameController.text.trim(), userimage: imagepath?.path));
      return true;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('field cant be empty')));
      return false;
    }
  }
}
