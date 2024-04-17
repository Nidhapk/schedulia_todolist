// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:schedulia/widgets/custom_button.dart';
import 'package:schedulia/widgets/custom_snackbar.dart';
import 'package:schedulia/widgets/textfield/passoword_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              const SizedBox(height: 50),
              PasswordField(
                  mode: AutovalidateMode.onUserInteraction,
                  controller: oldPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password can\'t be empty';
                    } else if (oldPasswordController.text.trim() !=
                        userListNotifier.value[int.parse(userKey!)].password) {
                      return 'incorrect password';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'old password'),
              PasswordField(
                  mode: AutovalidateMode.onUserInteraction,
                  controller: newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please fill the field';
                    } else if (value.length < 8) {
                      return 'The password must contain atleast 8 characters';
                    } else if (!RegExp(r'[A-Z]').hasMatch(value) ||
                        !RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Password must contain at least one uppercase letter and one number';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'new password'),
              PasswordField(
                  mode: AutovalidateMode.onUserInteraction,
                  controller: confirmNewPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please fill the field';
                    } else if (confirmNewPasswordController.text.trim() !=
                        newPasswordController.text.trim()) {
                      return 'new password and confirm password should match';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'Confirm password'),
              Custombutton(
                onpressed: () async {
                  await editButtonOnClicked().then((value) =>
                      CustomSnackBar.show(
                          context, 'Password has been successfully changed'));
                },
                text: 'Edit',
                //width: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editButtonOnClicked() async {
    if (formkey.currentState!.validate()) {
      await UserFunctions()
          .changePassword(
              UserModel(password: confirmNewPasswordController.text.trim()))
          .then((value) => Navigator.of(context).pop());
    }
  }
}
