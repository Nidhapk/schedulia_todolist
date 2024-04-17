import 'package:flutter/material.dart';
import 'package:schedulia/screens/home_screen/event/search_events.dart';
import 'package:schedulia/widgets/colors.dart';
import 'package:schedulia/widgets/event/important_events.dart';
import 'package:schedulia/widgets/event/upcomeing_events.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _TaskTabBarState();
}

class _TaskTabBarState extends State<EventScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late TabController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        toolbarHeight: 15,
      ),
      body: Container(
        color: white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                // const SizedBox(
                //   height: 40,
                //  ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 151, 145, 153),
                      borderRadius: BorderRadius.circular(8)),
                  child: TabBar(
                    dividerHeight: 0,
                    indicatorColor: darkpurple,
                    indicatorPadding: const EdgeInsets.all(5),
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), color: white),
                    controller: controller,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(
                        child: Text(
                          'All',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Favourites',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'search',
                          style: TextStyle(fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: const [
                      // AddEvents(),
                      UpcomeingEvents(),
                      ImportantEvents(),
                      SearchEvent()
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
