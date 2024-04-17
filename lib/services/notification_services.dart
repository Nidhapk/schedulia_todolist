import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> requestNotificationPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static onTap(details) {}
  static Future initt() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static showScheduledNotification(
      {TimeOfDay? time, DateTime? date, String? title, body}) async {
    AndroidNotificationDetails android = const AndroidNotificationDetails(
      'id3', 'Scheduled Notification',
      importance: Importance.max,
      priority: Priority.high,
      // styleInformation: BigTextStyleInformation(
      //   title!,
      //   htmlFormatTitle: true,
      //   htmlFormatContent: true,
      // )
    );
    NotificationDetails details = NotificationDetails(
      android: android,
    );
    tz.initializeTimeZones();
    //print(log(tz.local as num));
    log(tz.TZDateTime.now(tz.local).hour);
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    int year = date!.year;
    int month = date.month;
    int day = date.day;
    int hour = time!.hour;
    int minute = time.minute;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      title,
      body,
      // tz.TZDateTime.now(tz.local).add(Duration(seconds: 10)
      //),

      tz.TZDateTime(
        tz.local,
        year,
        month,
        day,
        hour,
        minute,
      ),
      //tz.TZDateTime(tz.local, 2024, 3, 30, 15, 2, 0),
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
