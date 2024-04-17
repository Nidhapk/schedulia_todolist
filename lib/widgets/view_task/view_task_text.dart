import 'package:flutter/material.dart';
import 'package:schedulia/widgets/colors.dart';

class Tasktext extends StatelessWidget {
  final String taskTitle;
  final String details;
  //final TaskModel task;
  const Tasktext({
    super.key,
    required this.taskTitle,
    required this.details,
    //required this.task
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 35),
          child: Text(
            taskTitle,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: grey),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 35),
            child: Text(
              details,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
