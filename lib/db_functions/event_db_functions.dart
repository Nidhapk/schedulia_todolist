import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:schedulia/db_functions/db_functions.dart';
import 'package:schedulia/model/event/event_model.dart';

ValueNotifier<List<EventModel>> eventNotifier = ValueNotifier([]);
//ValueNotifier<List<EventModel>> currentUserEventNotifier = ValueNotifier([]);
ValueNotifier<List<EventModel>> filteredEventsNotifier = ValueNotifier([]);
ValueNotifier<List<EventModel>> importantEventNotifier = ValueNotifier([]);

class EventFunctions extends ChangeNotifier {
  Future addEvent(EventModel model) async {
    final Box<EventModel> eventBox = await Hive.openBox<EventModel>('event_db');
    await eventBox.add(model);
    await getallEvents();
    await eventBox.close();
  }

  Future getallEvents() async {
    final Box<EventModel> eventBox = await Hive.openBox<EventModel>('event_db');
    eventNotifier.value.clear();
    eventNotifier.value.addAll(eventBox.values);
    eventNotifier.notifyListeners();
  }

  Future<List<EventModel>> getCurrentUserevents(String userKey) async {
    final Box<EventModel> eventBox = await Hive.openBox<EventModel>('event_db');
    List<EventModel> allEvents = eventBox.values.toList();
    List<EventModel> currentUserEvents =
        allEvents.where((events) => events.userKey == userKey).toList();
    return currentUserEvents;
  }

  Future getCurrentUserEventsOnSelectedDay(
      DateTime? startdate, DateTime? endDate) async {
    String? key = await UserFunctions(). getCurrentUserKey();
    List<EventModel> currentUserEvents = await getCurrentUserevents(key!);
    List<EventModel> filteredEvents = currentUserEvents.where((events) {
      if (events.eventDate == null || startdate == null || endDate == null) {
        return false;
      }
      DateTime eventDate = DateFormat('dd-MMM-yyyy').parse(events.eventDate!);

      return eventDate == startdate ||
          eventDate.isAfter(startdate) && eventDate.isBefore(endDate) ||
          eventDate == endDate;
    }).toList();
    filteredEventsNotifier.value = filteredEvents;
    filteredEventsNotifier.notifyListeners();

    return filteredEvents;
  }

  Future filterEventsBasedOnSearch(String title) async {
    String? key = await UserFunctions(). getCurrentUserKey();
    List<EventModel> currentUserEvents = await getCurrentUserevents(key!);

    List<EventModel> filteredEvents = currentUserEvents
        .where((events) =>
            events.eventTitle!.toLowerCase().contains(title.toLowerCase()))
        .toList();
    if (title == '') filteredEvents = [];
    return filteredEvents;
  }

  Future getImportantEvents() async {
    String? key = await UserFunctions(). getCurrentUserKey();
    List<EventModel> currentUserEvents = await getCurrentUserevents(key!);
    List<EventModel> importantEvents = currentUserEvents
        .where((events) => events.isImportant == true)
        .toList();
    importantEventNotifier.value.clear();
    importantEventNotifier.value.addAll(importantEvents);
    importantEventNotifier.notifyListeners();
    return importantEvents;
  }

  Future editEvents(EventModel value, int key) async {
    final Box<EventModel> eventBox = await Hive.openBox<EventModel>('event_db');
    await eventBox.put(key, value);
   await  getallEvents();
  }

  Future deleteEvent(int key) async {
    final Box<EventModel> eventBox = await Hive.openBox<EventModel>('event_db');
    await eventBox.delete(key);
   await  getallEvents();
  }
}
