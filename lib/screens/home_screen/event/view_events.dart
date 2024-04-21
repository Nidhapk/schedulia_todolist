// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:schedulia/model/event/event_model.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/event/eventview_column.dart';
import 'package:schedulia/widgets/event/eventview_rows.dart';

class ViewEvents extends StatelessWidget {
  EventModel index;
  ViewEvents({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        toolbarHeight: 50,
        foregroundColor: appBarColor,
        backgroundColor: white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                  colors: [viewContainerColorOne, viewContainerColorTwo]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventViewRow(title: 'Title', body: index.eventTitle!),
                const Divider(thickness: 1),
                EventViewRow(title: 'Date', body: index.eventDate!),
                const Divider(thickness: 1),
                EventViewRow(title: 'Time', body: index.eventTime!),
                const Divider(thickness: 1),
                EventViewcolumn(title: 'location', body: index.eventlocation!),
                const Divider(thickness: 1),
                index.eventDescription != null &&
                        index.eventDescription!.isNotEmpty
                    ? EventViewcolumn(
                        title:
                            index.eventDescription != null ? 'Description' : '',
                        body: index.eventDescription ?? '',
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                index.eventImage == null || index.eventImage!.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PhotoView(
                                    imageProvider:
                                        FileImage(File(index.eventImage!)))));
                          },
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.file(File(index.eventImage!))),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
