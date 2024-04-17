import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:schedulia/model/categoy/category_model.dart';
import 'package:schedulia/model/event/event_model.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/model/user/user_model.dart';
import 'package:schedulia/screens/home_screen/home_screen.dart';
import 'package:schedulia/screens/home_screen/perfomance/app_info.dart';
import 'package:schedulia/screens/home_screen/perfomance/privacy_policy.dart';
import 'package:schedulia/screens/home_screen/perfomance/view_profile.dart';
import 'package:schedulia/screens/home_screen/task/add_new_task.dart';
import 'package:schedulia/screens/login_signup/login_screen.dart';
import 'package:schedulia/screens/splash/splash_screen.dart';
import 'package:schedulia/screens/user_profile/change_password.dart';
import 'package:schedulia/screens/user_profile/edi_profile_screen.dart';
import 'package:schedulia/services/notification_services.dart';
import 'package:schedulia/widgets/event/add_events.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  await Hive.openBox<UserModel>('user_db');

  if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
    Hive.registerAdapter(TaskModelAdapter());
  }
  await Hive.openBox<TaskModel>('task_db');

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  await Hive.openBox<CategoryModel>('category_db');

  if (!Hive.isAdapterRegistered(EventModelAdapter().typeId)) {
    Hive.registerAdapter(EventModelAdapter());
  }
  await LocalNotificationService.initt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/viewProfile': (context) => const ViewProfile(),
        '/privacyPolicy': (context) => const PrivacyPolicyScrren(),
        '/loginPage': (context) => const LoginScreen(),
        '/editProfile': (context) => const EditProfile(),
        '/changePassword': (context) => const ChangePassword(),
        '/appInfoPage': (context) => const AppInfoScreen(),
        '/addTask':(context) =>  AddNewTask(),
        '/addEvent':(context) => const AddEvents(),
        '/homeScreen':(context) => const HomeScreen(),
        
  
      },
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
