import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EventsOverviewView extends StatefulWidget {
  const EventsOverviewView({Key? key}) : super(key: key);

  @override
  _EventsOverviewViewState createState() => _EventsOverviewViewState();
}

class _EventsOverviewViewState extends State<EventsOverviewView> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Opened'),
    Text('Index 1: Planned'),
    Text('Index 2: Done'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              activeIcon: Icon(PhosphorIcons.squareFill), icon: Icon(PhosphorIcons.squareLight), label: 'Opened'),
          BottomNavigationBarItem(
              activeIcon: Icon(PhosphorIcons.calendarFill), icon: Icon(PhosphorIcons.calendarLight), label: 'Planned'),
          BottomNavigationBarItem(
              activeIcon: Icon(PhosphorIcons.checkSquareFill),
              icon: Icon(PhosphorIcons.checkSquareLight),
              label: 'Done'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
