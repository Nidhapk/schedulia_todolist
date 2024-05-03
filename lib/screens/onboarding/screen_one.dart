import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedulia/screens/onboarding/screen_two.dart';
import 'package:schedulia/widgets/circle.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Circle(width:370,
                height: height * 0.5,
              ),
              Positioned(
                top: 100.0,
                left: 20.0,
                child: SvgPicture.asset(
                  'lib/assets/welcome_screen_one/undraw_enter_uhqk (1).svg',
                  width: width * 0.23
                  // 260.0
                  ,
                  height: height * 0.36
                  //260.0
                  ,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left:width<600? width * 0.1:width*0.3,
                // 40.0
                top: height* 0.05
                //70.0
                ),
            
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Get things done with \nSCHEDULIA',
                      style: TextStyle(fontSize: height*0.063, height: 1.2),
                    ),
                  ),
                ],
              ),
                  
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width<600? width * 0.1:width*0.3,
              top: height * 0.02,
            ),
            child:  Text(
              'let\'s help you meet up your tasks. ',
              style: TextStyle(fontSize: height*0.024),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width<600? width * 0.1:width*0.3,
              top: height * 0.03,
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
