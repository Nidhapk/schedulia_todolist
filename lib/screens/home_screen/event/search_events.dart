import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schedulia/db_functions/event_db_functions.dart';
import 'package:schedulia/model/event/event_model.dart';
import 'package:schedulia/screens/home_screen/event/view_events.dart';

class SearchEvent extends StatefulWidget {
  const SearchEvent({super.key});

  @override
  State<SearchEvent> createState() => _SearchEventState();
}

class _SearchEventState extends State<SearchEvent> {
  List<EventModel> _filteredEvents = [];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //filterEventsBasedOnSearch(searchController.text.trim());
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 197, 185, 197)
                          .withOpacity(0.8),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              child: TextFormField(
                controller: searchController,
                onChanged: _filteredEventss,
                decoration: InputDecoration(
                    hintText: 'Search here...',
                    prefixIcon: const Icon(
                      Icons.search_outlined,
                      color: Color.fromARGB(255, 89, 65, 130),
                    ),
                    fillColor: const Color.fromARGB(255, 240, 232, 249),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none)),
              ),
            )),
        Expanded(
          child: _filteredEvents.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'lib/assets/task/undraw_location_search_re_ttoj.svg',
                      height: 150,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No such event found'),
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: _filteredEvents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 3),
                                )
                              ],
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 252, 219, 205),
                                  Color.fromARGB(255, 232, 203, 249),
                                ],
                              )),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewEvents(
                                      index: _filteredEvents[index])));
                            },
                            leading: _filteredEvents[index].eventImage != null
                                ? SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.file(File(
                                        _filteredEvents[index].eventImage ??
                                            '')))
                                : null,
                            title: Text(_filteredEvents[index].eventTitle!),
                            subtitle:
                                Text(_filteredEvents[index].eventDate ?? ''),
                            trailing:
                                Text(_filteredEvents[index].eventTime ?? ''),
                          ),
                        ));
                  }),
        )
      ],
    );
  }

  _filteredEventss(title) async {
    List<EventModel> events =
        await EventFunctions().filterEventsBasedOnSearch(title);

    setState(() {
      _filteredEvents = events;
    });
  }
}
