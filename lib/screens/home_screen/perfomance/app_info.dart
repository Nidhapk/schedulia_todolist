import 'package:flutter/material.dart';
import 'package:schedulia/class/custom_textstyle.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: const [
          Text('About Our App', style: MyTextStyle.appNameStyle),
          SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'lib/assets/logo/Untitled design (1).png',
                height: 140,
              ),
              const Center(
                child: Text('SCHEDULIA', style: MyTextStyle.privacypolicyStyle),
              ),
              const Center(
                child: Text('Version 1.0.0'),
              ),
              const SizedBox(height: 30),
              const Text(
                'Introducing Schedulia - Your Personal Day Planner!\n\nStay on top of your busy schedule with Schedulia - the ultimate task manager and day planner. Effortlessly schedule tasks, categorize them for easy organization, and receive timely notifications to keep you on track. Plan your day ahead with the intuitive calendar feature.\n\n Download Schedulia now and take control of your time like never before!',
                style: MyTextStyle.aboutBodyStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
