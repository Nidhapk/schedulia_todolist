// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/screens/onboarding/screen_one.dart';

import '../../model/user/user_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  String? key;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    initializeCurrentUser();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('lib/assets/splash/splashScreen_animation.json',
            controller: controller, width: 300, onLoaded: (con) {
          controller.duration = con.duration;
          controller.forward().whenComplete(isUserRegistered);
        }),
      ),
    );
  }

  Future<void> isUserRegistered() async {
    bool checkUser = await UserFunctions().checkuser();
    bool isLoggedIn = await UserFunctions().isLoggedIn();
    await UserFunctions().getUser();
    if (checkUser == false) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ScreenOne()));
    } else if (isLoggedIn == true) {
      {
        Navigator.pushReplacementNamed(context, '/homeScreen');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/loginPage');
    }
  }

  Future initializeCurrentUser() async {
    await UserFunctions().getCurrentUserKey();
  }

  initializeuser() async {
    UserModel? user = await UserFunctions().getCurrentUser(userKey!);
    return user;
  }
}
