import 'dart:io';

import 'package:flutter/material.dart';
import 'package:schedulia/db_functions/event_db_functions.dart';
import 'package:schedulia/screens/home_screen/event/view_events.dart';
import 'package:schedulia/widgets/event/empty_event.dart';
import 'package:schedulia/widgets/event/evet_container.dart';

class ImportantEvents extends StatefulWidget {
  const ImportantEvents({super.key});

  @override
  State<ImportantEvents> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ImportantEvents> {
  @override
  void initState() {
    super.initState();
    loadImportantEvents();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: importantEventNotifier,
      builder: (context, value, child) {
        if (value.isEmpty) {
          return const EmptyEvent(text: 'No important events has been marked');
        } else {
          return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: EventContainer(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ViewEvents(
                                index: value[index],
                              ),
                            ),
                          );
                        },
                        leading: value[index].eventImage != null &&
                                value[index].eventImage!.isNotEmpty
                            ? SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.file(
                                  File(value[index].eventImage!),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : null,
                        title: Text(
                          value[index].eventTitle!,
                        ),
                        subtitle: Text(value[index].eventDate!),
                        trailing: Text(value[index].eventTime!),
                      ),
                    ));
              });
        }
      },
    );
  }

  Future<void> loadImportantEvents() async {
    // Wait for the asynchronous operation to complete
    await EventFunctions().getImportantEvents();
    // Once complete, the UI will rebuild with the updated data
  }
}
