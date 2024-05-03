import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedulia/screens/onboarding/screen_five.dart';
import 'package:schedulia/services/notification_services.dart';
import 'package:schedulia/widgets/circle.dart';

ValueNotifier<bool>? isgranted;

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(children: [
        Circle(
          width: 370,
          height: height * 0.5,
        ),
        Positioned(
          top: height * 0.15,
          left: 50,
          child: SvgPicture.asset(
            'lib/assets/New message-cuate.svg',
            width: width * 0.28,
            height: height * 0.35,
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.46),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                'Stay On Track:\nSet Task Notifications!',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: height * 0.028,
                    wordSpacing: 2),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Set reminders for each task and let us \nkeep you in sync with your goals. ',
                style: TextStyle(
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 1),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.5),
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

  // Future<void> initializeNotificationPermission() async {
  //   bool? granted =
  //       await LocalNotificationService.requestNotificationPermissions();
  //   isgranted!.value = granted ?? false;
  //   setState(() {
  //     isgranted = isgranted;
  //   });
  // }
}

// Future<bool?> requestNotificationPermission() async {
//   final bool? isGranted =
//       await LocalNotificationService.requestNotificationPermissions();
//   return await isGranted;
// }
