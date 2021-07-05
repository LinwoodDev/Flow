import 'package:flow_app/events/details.dart';
import 'package:flow_app/services/api_service.dart';
import 'package:flow_app/services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/event.dart';

class EventsOverviewView extends StatefulWidget {
  const EventsOverviewView({Key? key}) : super(key: key);

  @override
  _EventsOverviewViewState createState() => _EventsOverviewViewState();
}

class _EventsOverviewViewState extends State<EventsOverviewView> {
  int _selectedIndex = 1;
  late ApiService service;

  @override
  void initState() {
    super.initState();

    service = GetIt.I.get<LocalService>();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void openDialog(Event? event) => showDialog(
      context: context,
      builder: (context) => Dialog(
          child: Container(
              constraints: const BoxConstraints(maxHeight: 750, maxWidth: 500),
              child: EventPage(isDesktop: true, isDialog: true, id: event?.id))));

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      StreamBuilder<List<Event>>(
        stream: service.onOpenedEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Text("Error: ${snapshot.error}");
          var events = snapshot.data!;
          return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                var event = events[index];
                return ListTile(
                  title: Text(event.name),
                  onTap: () => openDialog(event),
                );
              });
        },
      ),
      StreamBuilder<List<Event>>(
        stream: service.onPlannedEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Text("Error: ${snapshot.error}");
          var events = snapshot.data!;
          return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                var event = events[index];
                return ListTile(
                  title: Text(event.name),
                  onTap: () => openDialog(event),
                );
              });
        },
      ),
      StreamBuilder<List<Event>>(
        stream: service.onDoneEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Text("Error: ${snapshot.error}");
          var events = snapshot.data!;
          return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                var event = events[index];
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text(event.isCanceled ? "Canceled" : ""),
                  onTap: () => openDialog(event),
                );
              });
        },
      )
    ];
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => openDialog(null),
            label: const Text("Create event"),
            icon: const Icon(PhosphorIcons.plusLight)),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              activeIcon: Icon(PhosphorIcons.squareFill),
              icon: Icon(PhosphorIcons.squareLight),
              label: 'Opened'),
          BottomNavigationBarItem(
              activeIcon: Icon(PhosphorIcons.calendarFill),
              icon: Icon(PhosphorIcons.calendarLight),
              label: 'Planned'),
          BottomNavigationBarItem(
              activeIcon: Icon(PhosphorIcons.checkSquareFill),
              icon: Icon(PhosphorIcons.checkSquareLight),
              label: 'Done'),
        ], currentIndex: _selectedIndex, onTap: _onItemTapped));
  }
}
