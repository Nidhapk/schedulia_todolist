import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedulia/screens/onboarding/screen_five.dart';
import 'package:schedulia/services/notification_services.dart';
import 'package:schedulia/widgets/circle.dart';

class ScreenFour extends StatefulWidget {
  const ScreenFour({super.key});

  @override
  State<ScreenFour> createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  @override
  void initState() {
    super.initState();
    LocalNotificationService.requestNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(children: [
        const Circle(),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 87),
              SvgPicture.asset(
                'lib/assets/New message-cuate.svg',
                width: 320,
                height: 320,
              ),
              const SizedBox(
                height: 80,
              ),
              const Text(
                'Stay On Track:\nSet Task Notifications!',
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 20, wordSpacing: 2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Set reminders for each task and let us \nkeep you in sync with your goals. ',
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w400, wordSpacing: 1),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 140,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 230.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScreenFive()));
                    },
                    child: const Text('Next >>')),
              )
            ],
          ),
        ),
      ])),
    );
  }
}
