import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedulia/screens/onboarding/screen_two.dart';
import 'package:schedulia/widgets/circle.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const Circle(),
              Positioned(
                top: 120.0,
                left: 40.0,
                child: SvgPicture.asset(
                  'lib/assets/welcome_screen_one/undraw_enter_uhqk (1).svg',
                  width: 260.0,
                  height: 260.0,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                // 40.0
                top: MediaQuery.of(context).size.width * 0.15
                //70.0
                ),
            child: const Text(
              'Get things\ndone with\nSCHEDULIA',
              style: TextStyle(fontSize: 45.0, height: 1.2),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.width * 0.05,
            ),
            child: const Text(
              'let\'s help you meet up your tasks. ',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.width * 0.05,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ScreenTwo()));
              },
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                ),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
                backgroundColor: const MaterialStatePropertyAll(
                  Color.fromARGB(255, 59, 56, 63),
                ),
              ),
              child: const Text(
                'GET STARTED',
              ),
            ),
          )
        ],
      ),
    );
  }
}
