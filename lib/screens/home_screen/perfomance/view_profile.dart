import 'dart:io';
import 'package:flutter/material.dart';
import 'package:schedulia/class/custom_textstyle.dart';
import 'package:schedulia/db_functions/db_functions.dart';

import 'package:schedulia/screens/home_screen/perfomance/view_profile_row.dart';
import 'package:schedulia/widgets/alert_box/alert_box.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/perfomance/image_container.dart';
import 'package:schedulia/widgets/popup/image_popup.dart';
import 'package:schedulia/widgets/view_task/custom_container_new.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    initializeUser();
    return Scaffold(
        backgroundColor: appBarColor,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: appBarColor,
          foregroundColor: white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          title: const Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: NewCustomContainer(
            child: ValueListenableBuilder(
              valueListenable: userListNotifier,
              builder: (context, value, child) {
                return Column(
                  children: [
                    const SizedBox(height: 30),
                    ImagePopUp(
                      condition:
                          value[keys.indexOf(userKey!)].userimage != null,
                      child2: value[keys.indexOf(userKey!)].userimage != null
                          ? Image.file(
                              File(value[keys.indexOf(userKey!)].userimage!))
                          : Image.asset(''),
                      child: ImageContainer(
                          condition:
                              value[keys.indexOf(userKey!)].userimage != null,
                          imageProvider:
                              value[keys.indexOf(userKey!)].userimage != null
                                  ? FileImage(File(
                                      value[keys.indexOf(userKey!)].userimage!))
                                  : FileImage(File(''))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 30),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Text(value[keys.indexOf(userKey!)].name ?? '',
                            style: MyTextStyle.namestyle),
                      ),
                    ),
                    Container(
                        color: lightGrey,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 13.0, bottom: 13.0, left: 20),
                          child: Text('General Settings',
                              style: MyTextStyle.settingStyle),
                        )),
                    ViewprofileRow(
                        onTap: () {
                          Navigator.of(context).pushNamed('/editProfile');
                        },
                        icon: Icons.person,
                        text: 'Edit Profile'),
                    const Divider(thickness: 1),
                    ViewprofileRow(
                        onTap: () {
                          Navigator.of(context).pushNamed('/changePassword');
                        },
                        icon: Icons.password_rounded,
                        text: 'Change Password'),
                    const Divider(thickness: 1),
                    ViewprofileRow(
                        icon: Icons.person_off,
                        text: 'Delete Account',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomAlertBox(
                                  title: 'Delete acoount?',
                                  text:
                                      'Are you sure you want to delete this account?',
                                  onpressedCancel: () {
                                    Navigator.of(context).pop();
                                  },
                                  onpressedDelete: () async {
                                    await UserFunctions()
                                        .deleteUser(keys.indexOf(userKey!))
                                        .then((value) => Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/loginPage',
                                                (route) => false));
                                  });
                            },
                          );
                        })
                  ],
                );
              },
            ),
          ),
        ));
  }

  initializeUser() async {
    return await UserFunctions().getCurrentUser(userKey!);
  }
}
