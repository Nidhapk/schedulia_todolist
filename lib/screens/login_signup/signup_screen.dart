// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:schedulia/screens/user_profile/profile_screen.dart';
import 'package:schedulia/widgets/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassword = TextEditingController();

  bool obsecureTextPass = true;
  bool obsecureTextPassConfirm = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 217, 216, 219),
              Color.fromARGB(255, 250, 244, 244)
            ], begin: Alignment.bottomLeft, end: Alignment.centerLeft)),
            child: Center(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 237, 226, 252),
                                  Color.fromARGB(255, 255, 212, 218),
                                  Color.fromARGB(255, 220, 202, 245),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topLeft),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: SvgPicture.asset(
                              'lib/assets/Prototyping process-pana.svg',
                              height: 250,
                              width: 250,
                            ),
                          ),
                        )
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: appBarColor,
                            fontSize: 50),
                      ),
                      const Text('Create your account'),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: usernameController,
                          validator: (value) {
                            final trimmedValue = value?.trim();
                            if (trimmedValue == null || trimmedValue.isEmpty) {
                              return 'userName cant\'be empty';
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            prefixIcon: const Icon(Icons.person_2_rounded),
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(color: darkpurple)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password can\'t be empty';
                            } else if (value.length < 8) {
                              return 'The password must contain atleast 8 characters';
                            } else if (!RegExp(r'[A-Z]').hasMatch(value) ||
                                !RegExp(r'[0-9]').hasMatch(value)) {
                              return 'Password must contain at least one uppercase letter and one number';
                            } else {
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: obsecureTextPass,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock_person),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsecureTextPass = !obsecureTextPass;
                                  });
                                },
                                icon: Icon(obsecureTextPass
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(color: darkpurple)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: confirmpassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'confirm password can\'t be empty';
                            } else if (passwordController.text.trim() !=
                                confirmpassword.text.trim()) {
                              return ' password and confirm password should match.';
                            } else {
                              return null;
                            }
                          },
                          obscureText: obsecureTextPassConfirm,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: 'Confirm password',
                            prefixIcon: const Icon(Icons.lock_person),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsecureTextPassConfirm =
                                        !obsecureTextPassConfirm;
                                  });
                                },
                                icon: Icon(obsecureTextPassConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(color: darkpurple)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(appBarColor),
                              foregroundColor: MaterialStatePropertyAll(white)),
                          onPressed: () async {
                            bool alreadyExist = await UserFunctions()
                                .checkUserExist(usernameController.text.trim());

                            if (alreadyExist == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Username already taken')));
                            } else {
                              await signUp();
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 130.0),
                            child: Text('LOGIN'),
                          )),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    if (formKey.currentState!.validate()) {
      UserModel user = UserModel(
          userName: usernameController.text.trim(),
          password: passwordController.text.trim(),
          isBlocked: false);

      await UserFunctions().addUser(user).then((value) => Navigator.of(context)
          .push(
              MaterialPageRoute(builder: (context) => const ProfileScreen())));
    }
  }
}
