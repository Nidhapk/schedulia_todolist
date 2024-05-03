import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedulia/screens/login_signup/login_screen.dart';

class ScreenFive extends StatelessWidget {
  const ScreenFive({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                'Plan your days',
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize:height*0.032),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Never forget an upcoming event again! \nUse our calendar feature to mark important\n dates and stay prepared.',
                style: TextStyle(fontSize: height*0.019),
                textAlign: TextAlign.center,
              ),
              Stack(
                children: [
                  SvgPicture.asset(
                    'lib/assets/Events-pana.svg',
                    width: 200,
                    height: MediaQuery.of(context).size.height * 0.49,
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.5),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    child: const Text('Next >>')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
