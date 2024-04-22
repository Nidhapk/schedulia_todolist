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
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.2,
                top: MediaQuery.of(context).size.height * 0.15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How do you plan to use\nSchedulia?',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                ),
                //const SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: const Text(
                    'Categorize your task based on\nyour needs.',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                // const SizedBox(
                //   height: 200.0,
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.020),
                    child: const Row(
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
                  ),
                ),
                // const SizedBox(
                //   height: 25.0,
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.020),
                  child: const Row(
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
                ),
                // const SizedBox(
                //   height: 25.0,
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.020),
                  child: const Row(
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
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.15,
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: const Text('+ more other options'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.of(context).size.width * 0.5,
                  ),
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
