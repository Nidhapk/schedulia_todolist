import 'package:flutter/material.dart';
import 'package:schedulia/screens/onboarding/screen_three.dart';
import 'package:schedulia/widgets/circle.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Circle(),
          Padding(
            padding: const EdgeInsets.only(left: 80.0, top: 120.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How do you plan to use\nSchedulia?',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Categorize your task based on\nyour needs.',
                  style: TextStyle(fontSize: 15.0),
                ),
                const SizedBox(
                  height: 200.0,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.person_2_rounded,
                      color: Color.fromARGB(255, 255, 168, 96),
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Text(
                      'Personal',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.work_history,
                      color: Color.fromARGB(255, 219, 84, 84),
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Text(
                      'Work',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.monitor_heart,
                      color: Color.fromARGB(255, 98, 57, 213),
                      size: 40.0,
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Text(
                      'Health',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 60.0),
                  child: Text('+ more other options'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 200.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ScreenThree()));
                      },
                      child: const Text('Next >>')),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
