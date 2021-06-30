import 'package:flow_app/events/calendar.dart';
import 'package:flow_app/events/list.dart';
import 'package:flow_app/events/overview.dart';
import 'package:flow_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum EventView { list, calendar, overview }

extension EventViewExtension on EventView {
  IconData get icon {
    switch (this) {
      case EventView.list:
        return PhosphorIcons.listLight;
      case EventView.calendar:
        return PhosphorIcons.calendarLight;
      case EventView.overview:
        return PhosphorIcons.squaresFourLight;
    }
  }

  String get name {
    return this.toString();
  }

  Widget buildWidget() {
    switch (this) {
      case EventView.list:
        return EventsListView();
      case EventView.calendar:
        return EventsCalendarView();
      case EventView.overview:
        return EventsOverviewView();
    }
  }
}

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<int>>(
        valueListenable: Hive.box<int>('view').listenable(),
        builder: (BuildContext context, box, Widget? child) => FlowScaffold(
            page: RoutePages.events,
            pageTitle: "Events",
            actions: [
              IconButton(onPressed: () {}, icon: Icon(PhosphorIcons.funnelLight)),
              PopupMenuButton<EventView>(
                  initialValue: EventView.values[box.get("events", defaultValue: 0)!],
                  onSelected: (value) => box.put("events", value.index),
                  itemBuilder: (context) => EventView.values
                      .map((e) => PopupMenuItem(
                          value: e,
                          child:
                              ListTile(title: Text(e.name), leading: Icon(e.icon), selected: e == box.get("events"))))
                      .toList())
            ],
            body: EventView.values[box.get("events", defaultValue: 0)!].buildWidget()));
  }
}
