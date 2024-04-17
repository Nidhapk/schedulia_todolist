import 'package:flutter/material.dart';
import 'package:schedulia/class/menu_items.dart';
import 'package:schedulia/db_functions/category_db.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/popup/custom_popup.dart';

class CustomCategorycontainer extends StatefulWidget {
  final String category;
  final Widget? text;
  final String text2;
  final String text3;
  final IconData? icon;
  final VoidCallback onTap;

  const CustomCategorycontainer(
      {super.key,
      this.text,
      required this.icon,
      required this.text2,
      required this.text3,
      required this.onTap,
      required this.category});

  @override
  State<CustomCategorycontainer> createState() =>
      _CustomCategorycontainerState();
}

class _CustomCategorycontainerState extends State<CustomCategorycontainer> {
  bool _showFullText = false;
  bool _showFullText2 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 235, 232, 250), white],
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: darkpurple,
                        size: 30,
                      )
                    :const  SizedBox(),
              ),
              CustomPopUpButton(color: darkpurple, items: [
                MenuItem(
                    title: 'Delete',
                    icon: Icons.delete_outline_rounded,
                    onTap: widget.onTap),
              ]),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10.0),
              child: widget.text),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: Future.wait([
                CategoryFunctions().taskDoneinCategory(widget.category),
                CategoryFunctions().taskNotDoneinCategory(widget.category)
              ]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var taskDoneData = snapshot.data?[0];
                  var taskNotDoneData = snapshot.data?[1];

                  if (taskDoneData == 0 && taskNotDoneData == 0) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'No task in this category',
                        style: TextStyle(color: darkpurple, fontSize: 11),
                      ),
                    ));
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showFullText2 = !_showFullText2;
                            });
                          },
                          child: FutureBuilder(
                              future: CategoryFunctions()
                                  .taskDoneinCategory(widget.category),
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  return Container(
                                    width: 60,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color:
                                            Color.fromARGB(255, 214, 209, 239),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 194, 192, 192),
                                            blurRadius: 3,
                                            spreadRadius: 1,
                                            offset: Offset(0, 3),
                                          )
                                        ]),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '${snap.data.toString()} done',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Color.fromARGB(
                                                    255, 62, 40, 163)),
                                            textAlign: TextAlign.center,
                                            overflow: _showFullText2
                                                ? null
                                                : TextOverflow.ellipsis),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox(
                                    width: 30,
                                  );
                                }
                              }),
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _showFullText = !_showFullText;
                              });
                            },
                            child: FutureBuilder(
                                future: CategoryFunctions()
                                    .taskNotDoneinCategory(widget.category),
                                builder: (context, snap) {
                                  if (snap.hasData) {
                                    return Container(
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 239, 210, 210),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 194, 192, 192)
                                                  .withOpacity(0.7),
                                              blurRadius: 3,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 3),
                                            )
                                          ]),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${snap.data.toString()} not done',
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 149, 39, 39),
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.center,
                                            overflow: _showFullText
                                                ? null
                                                : TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                })),
                      ],
                    );
                  }
                } else {
                  return const Text('');
                }
              })
        ],
      ),
    );
  }
}
