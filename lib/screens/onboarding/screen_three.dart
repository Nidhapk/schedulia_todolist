import 'package:flutter/material.dart';
import 'package:schedulia/screens/onboarding/screen_four.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            const Text(
              'Always know what\'s next',
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              'Keep track on your tasks and,\nmake sure nothing slips away.',
              style: TextStyle(fontSize: 15.0, color: Colors.black87),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Container(
              // height: 300,
              // width: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 166, 161, 161),
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(width: 3.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(27.0),
                child: Image.asset(
                  'lib/assets/welcome_screen_three/Screenshot_20240416_092438.jpg',
                  fit: BoxFit.contain,
                  height: 450,
                  width: 204,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.5),
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
    );
  }
}
