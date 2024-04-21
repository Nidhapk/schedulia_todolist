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
                      condition: value[int.parse(userKey!)].userimage != null,
                      child2: value[int.parse(userKey!)].userimage != null
                          ? Image.file(
                              File(value[int.parse(userKey!)].userimage!),
                            )
                          : Image.asset(''),
                      child: ImageContainer(
                        condition:
                            value[int.parse(userKey!)].userimage != null &&
                                value[int.parse(userKey!)].userimage != '',
                        imageProvider: FileImage(
                          File(value[int.parse(userKey!)].userimage ?? ''),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                        child: value[int.parse(userKey!)].name != null
                            ? Text(value[int.parse(userKey!)].name ?? '',
                                style: MyTextStyle.namestyle)
                            : null),
                    const SizedBox(height: 15),
                    Container(
                      color: lightGrey,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 13.0, bottom: 13.0, left: 20),
                        child: Text('General Settings',
                            style: MyTextStyle.settingStyle),
                      ),
                    ),
                    ViewprofileRow(
                      icon: Icons.person,
                      text: 'Edit Profile',
                      onTap: () {
                        Navigator.of(context).pushNamed('/editProfile');
                      },
                    ),
                    const Divider(thickness: 1),
                    ViewprofileRow(
                      icon: Icons.password_rounded,
                      text: 'Change password',
                      onTap: () {
                        Navigator.of(context).pushNamed('/changePassword');
                      },
                    ),
                    const Divider(thickness: 1),
                    ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomAlertBox(okText: 'Delete',
                                title: 'Delete acoount?',
                                text:
                                    'Are you sure you want to delete this account?',
                                onpressedCancel: () {
                                  Navigator.of(context).pop();
                                },
                                onpressedDelete: () async {
                                  await UserFunctions()
                                      .blockeUser(int.parse(userKey!))
                                      .then((value) => Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/loginPage', (route) => false));
                                });
                          },
                        );
                      },
                      leading: const Icon(Icons.person_off),
                      title: const Padding(
                        padding: EdgeInsets.only(left: 28.0),
                        child: Text('Delete Account'),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }
}
