import 'package:flutter/material.dart';
import 'package:schedulia/class/custom_textstyle.dart';
import 'package:schedulia/class/menu_items.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/db_functions/task_db_functions.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:schedulia/screens/home_screen/task/task_screen/task_done.dart';
import 'package:schedulia/screens/home_screen/task/task_screen/task_not_done.dart';
import 'package:schedulia/widgets/category/user_container.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/perfomance/custom_progress_indicator.dart';
import 'package:schedulia/widgets/perfomance/perfomance_circle.dart';
import 'package:schedulia/widgets/popup/custom_popup.dart';

// ignore: must_be_immutable
class PerfomanceScreen extends StatelessWidget {
  PerfomanceScreen({super.key});
  ValueNotifier<int?> perfomanceNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    int userPerfomance = perfomaceONThisDay();
    TaskFunctions().getTaskNotDone();
    TaskFunctions().getTaskDone();
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        screenGradient,
        const Color.fromARGB(255, 250, 250, 252),
        white
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: userListNotifier,
              builder:
                  (BuildContext context, List<UserModel> userList, Widget? _) {
                //UserFunctions().getCurrentUser(userKey!);
                return Stack(children: [
                  UserContainer(
                      // userModel: userList[int.parse(userKey!)],
                      text: userList[keys.indexOf(userKey!)].name != null
                          ? userList[keys.indexOf(userKey!)].name!
                          : '',
                      img: userList[keys.indexOf(userKey!)].userimage ?? ''),
                  Padding(
                    padding: const EdgeInsets.only(left: 320, top: 50),
                    child: CustomPopUpButton(
                      color: white,
                      items: [
                        MenuItem(
                            title: 'Profile',
                            icon: Icons.account_circle_rounded,
                            onTap: () {
                              Navigator.pushNamed(context, '/viewProfile');
                            }),
                        MenuItem(
                            title: 'Privacy policy',
                            icon: Icons.privacy_tip,
                            onTap: () {
                              Navigator.pushNamed(context, '/privacyPolicy');
                            }),
                        MenuItem(
                            title: 'App info',
                            icon: Icons.info_outline,
                            onTap: () {
                              Navigator.pushNamed(context, '/appInfoPage');
                            }),
                        MenuItem(
                            title: 'Logout',
                            icon: Icons.logout_rounded,
                            onTap: () async {
                              await UserFunctions()
                                  .checkUserLoggedIn(false, userKey!)
                                  .then((value) =>
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/loginPage', (route) => false));
                            })
                      ],
                    ),
                  )
                ]);
              }),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ValueListenableBuilder(
                valueListenable: taskDoneNotifier,
                builder: (context, List<TaskModel> taskDoneList, child_) {
                  return PerfomanceCircle(
                    text1: taskDoneList.length.toString(),
                    image:
                        'lib/assets/perfomance/circle-outline-of-small-size-purple.png',
                    text2: 'Completed',
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: taskNotDoneNotifier,
                builder: (context, List<TaskModel> taskNotDone, child) {
                  return PerfomanceCircle(
                    text1: taskNotDone.length.toString(),
                    image:
                        'lib/assets/perfomance/circle-outline-of-small-size-red.png',
                    text2: 'Not Completed',
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 60),
          Center(
            child: ValueListenableBuilder(
              valueListenable: perfomanceNotifier,
              builder: (context, perfomance, child_) {
                return GradientCircularPercentIndicator(
                    radius: 100.0, percent: perfomance! / 100);
              },
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          if (userPerfomance >= 80)
            const Text(
              'Congratulations! \nYour performance is outstanding!\n Keep up the great work!',
              textAlign: TextAlign.center,
              style: MyTextStyle.userFeedbackStyle,
            )
          else if (userPerfomance >= 50 && userPerfomance < 80)
            const Text(
              'Good job!\n You\'re making progress with your tasks. \nKeep it up!',
              textAlign: TextAlign.center,
              style: MyTextStyle.userFeedbackStyle,
            )
          else if (userPerfomance >= 20 && userPerfomance < 50)
            const Text(
              'You\'ve completed fewer tasks. \nLet\'s try to tackle more tasks today!',
              textAlign: TextAlign.center,
              style: MyTextStyle.userFeedbackStyle,
            )
          else if (userPerfomance == 0)
            const Text('')
          else
            const Text(
              'It looks like there\'s room for improvement.\n Stay Focused!',
              textAlign: TextAlign.center,
              style: MyTextStyle.userFeedbackStyle,
            )
        ],
      ),
    );
  }

  perfomaceONThisDay() {
    List<TaskModel> currentUserallTasks = currentUserTaskNotifier.value;
    final completedTask =
        currentUserallTasks.where((element) => element.iscompleted!).length;
    final totalTask = currentUserallTasks.length;
    int perfomanceOfUser;
    if (totalTask != 0) {
      perfomanceOfUser = ((completedTask / totalTask) * 100).toInt();
      perfomanceNotifier.value = perfomanceOfUser;
    } else {
      perfomanceNotifier.value = 0;
      perfomanceOfUser = 0;
    }
    return perfomanceOfUser;
  }
}
