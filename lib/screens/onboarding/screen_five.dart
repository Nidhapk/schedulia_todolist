import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedulia/screens/login_signup/login_screen.dart';

class ScreenFive extends StatelessWidget {
  const ScreenFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const Text(
                'Plan your days',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const Text(
                'Never forget an upcoming event again! \nUse our calendar feature to mark important\n dates and stay prepared.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Stack(
                children: [
                  SvgPicture.asset('lib/assets/Events-bro.svg'),
                  SvgPicture.asset('lib/assets/Events-pana.svg')
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
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
