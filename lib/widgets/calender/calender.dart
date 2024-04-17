import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class CustomCalender extends StatelessWidget {
  final Function(DateTime, DateTime) onDayselected;
  final bool Function(DateTime)? fun;
  CustomCalender({super.key, required this.onDayselected, required this.fun});
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TableCalendar(
          rowHeight: 45,
          headerStyle: const HeaderStyle(
              formatButtonVisible: false, titleCentered: true),
          calendarStyle: CalendarStyle(
              selectedDecoration:
                  BoxDecoration(color: darkpurple, shape: BoxShape.circle),
              todayDecoration:
                  BoxDecoration(color: indigo, shape: BoxShape.circle)),
          focusedDay: today,
          firstDay: DateTime.utc(1900, 01, 01),
          lastDay: DateTime.utc(2030),
          availableGestures: AvailableGestures.all,
          onDaySelected: onDayselected,
          selectedDayPredicate: fun,
        ),
      ],
    );
  }
}
