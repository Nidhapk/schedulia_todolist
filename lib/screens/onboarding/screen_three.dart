import 'package:flutter/material.dart';
import 'package:schedulia/screens/onboarding/screen_four.dart';
import 'package:schedulia/widgets/colors.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(backgroundColor:white,
      body: Stack(children: [
        Center(child: Image.asset('lib/assets/welcome_screen_three/task_screenshot.png',height: height)),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                'Always know what\'s next',
                style: TextStyle(fontSize: height*0.032, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
               Text(
                'Keep track on your tasks and,\nmake sure nothing slips away.',
                style: TextStyle(fontSize: height*0.020, color: Colors.black87),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.6,
                    left:width * 0.64),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScreenFour()));
                    },
                    child: const Text('Next >>')),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
