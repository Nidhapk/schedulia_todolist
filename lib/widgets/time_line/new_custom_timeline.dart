// ignore_for_file: camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:schedulia/model/task/task_model.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/task/custom_task_container.dart';
import 'package:timeline_tile/timeline_tile.dart';

class NewCustomTimeLine extends StatelessWidget {
  String title;
  List<Color> colors;
  String startTime;
  String endTime;
  Widget item1;
  Widget item2;
  Color lineColor;
  Color indicatorColor;
  Color textColor;
  TaskModel? taskModel;
  VoidCallback onTap;
  VoidCallback? onItem2;
  VoidCallback? onItem1;
  BoxBorder? border;
  Widget? widget;
  TextDecoration? decoration;
  TextDecoration subtitleDecoration;
  final Function(BuildContext) onPressed1;
  final Function(BuildContext) onPressed2;

  NewCustomTimeLine(
      {super.key,
      required this.title,
      required this.colors,
      required this.endTime,
      required this.startTime,
      required this.item1,
      required this.item2,
      this.decoration,
      this.border,
      this.taskModel,
      this.widget,
      this.onItem2,
      this.onItem1,
      required this.onTap,
      required this.onPressed1,
      required this.onPressed2,
      required this.lineColor,
      required this.indicatorColor,
      required this.textColor,
      required this.subtitleDecoration});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(30),
            icon: Icons.delete_rounded,
            foregroundColor: grey,
            onPressed: onPressed1,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(30),
            icon: Icons.mode_edit_sharp,
            foregroundColor: grey,
            onPressed: onPressed2,
          ),
        ],
      ),
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.23,
        beforeLineStyle: LineStyle(color: lineColor, thickness: 3),
        indicatorStyle: IndicatorStyle(
          width: 20,
          indicatorXY: 0.9,
          color: indicatorColor,
        ),
        endChild: Padding(
            padding: const EdgeInsets.only(left: 10, right: 17, bottom: 15),
            child: CustomTaskContainer(
                subtitleDecoration: subtitleDecoration,
                border: border,
                decoration: decoration,
                text: title,
                widget: PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          onTap: onItem1,
                          child: item1,
                        ),
                        PopupMenuItem(
                          onTap: onItem2,
                          child: item2,
                        )
                      ];
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(bottom: 18.0, left: 10),
                      child: Icon(
                        Icons.more_vert,
                        size: 18,
                      ),
                    )),
                onTap: onTap,
                colors: colors,
                startTime: startTime,
                endTime: endTime)),
        startChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                startTime,
                style: TextStyle(
                    decoration: subtitleDecoration,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                endTime,
                style: TextStyle(
                    decoration: subtitleDecoration,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
