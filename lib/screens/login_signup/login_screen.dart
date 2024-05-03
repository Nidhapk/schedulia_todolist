// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/screens/home_screen/home_screen.dart';
import 'package:schedulia/screens/login_signup/signup_screen.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();

  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool obscureText = true;
  late SharedPreferences pref;
  @override
  void initState() {
    initializeUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    //getCurrentUserKey();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 250, 246, 252),
            Color.fromARGB(255, 240, 232, 251),
            Color.fromARGB(255, 233, 223, 246),
            Color.fromARGB(255, 214, 206, 248),
            Color.fromARGB(255, 251, 211, 217),
          ], begin: Alignment.bottomCenter, end: Alignment.topLeft)),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'lib/assets/login_signup/undraw_welcome_re_h3d9.svg',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: width > 600 ? width * 0.3 : width * 0.1,right: width > 600 ? width * 0.3 : width * 0.1),
                  child: TextFormField(
                    controller: userNameController,
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
                  padding:  EdgeInsets.only(top: height*0.03,
                      
                      left: width > 600 ? width * 0.3 : width * 0.1,right: width > 600 ? width * 0.3 : width * 0.1),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(obscureText
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      ),
                      prefixIcon: const Icon(Icons.lock_person),
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(color: darkpurple)),
                    ),
                  ),
                ),
               SizedBox(
                  height: height*0.03,
                ),
                SizedBox(height: 60,width: width > 600 ? width * 0.4 : width * 0.8,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(appBarColor),
                          foregroundColor: MaterialStatePropertyAll(white)),
                      onPressed: () async {
                        final checkVariable = await UserFunctions()
                            .validateUserLogin(userNameController.text.trim(),
                                passwordController.text.trim());
                  
                        if (checkVariable != null) {
                          await UserFunctions().getCurrentUserKey();
                  
                          await UserFunctions()
                              .checkUserLoggedIn(true, userKey!)
                              .then((value) => Navigator.of(context)
                                ..pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const HomeScreen()),
                                    (route) => false));
                        } else {
                          showSnackBar(context);
                        }
                      },
                        child:const  Text('LOGIN'),
                      )
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ?',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignUp()));
                        },
                        child: const Text('Sign Up'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: appBarColor,
      content: const Text('Invalid username or password'),
    ));
  }

  initializeUser() async {
    return await UserFunctions().getCurrentUserKey();
  }
}
