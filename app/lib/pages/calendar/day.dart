import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';

import 'filter.dart';

class CalendarDayView extends StatefulWidget {
  final CalendarFilter filter;
  final String search;
  final PagingController<int, List<MapEntry<String, Event>>> controller;
  final ValueChanged<CalendarFilter> onFilterChanged;

  const CalendarDayView({
    super.key,
    required this.filter,
    this.search = '',
    required this.controller,
    required this.onFilterChanged,
  });

  @override
  State<CalendarDayView> createState() => _CalendarDayViewState();
}

class _CalendarDayViewState extends State<CalendarDayView> {
  final DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => widget.controller.refresh(),
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            DateFormat.yMMMMd(Localizations.localeOf(context).languageCode)
                .format(_date),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () => widget.controller.refresh(),
            child: const Icon(Icons.chevron_right),
          ),
        ],
      ),
      const Divider(),
      const SingleDayList(events: []),
    ]);
  }
}

class _EventListPosition {
  final Event event;
  final int position;

  _EventListPosition(this.event, this.position);
}

class SingleDayList extends StatelessWidget {
  final List<Event> events;

  static const _hourHeight = 100.0;
  static const _dividerHeight = 4.0;
  static const _positionWidth = 50.0;

  const SingleDayList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final positions = _getEventListPositions(events);
    final maxPosition =
        positions.isEmpty ? 0 : positions.map((e) => e.position).reduce(max);
    return SizedBox(
      height: 24 * _hourHeight + _dividerHeight,
      width: _positionWidth * (maxPosition + 1),
      child: Stack(
        children: [
          for (int i = 0; i < 24; i++)
            Positioned(
              top: i * _hourHeight,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  const Flexible(child: Divider()),
                  const SizedBox(width: 8),
                  Text(DateFormat.Hm(
                          Localizations.localeOf(context).languageCode)
                      .format(DateTime(0, 0, 0, i))),
                  const SizedBox(width: 8),
                  const Flexible(child: Divider()),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<_EventListPosition> _getEventListPositions(List<Event> events) {
    final positions = <_EventListPosition>[];
    for (final event in events) {
      final collide = positions.reversed
          .firstWhereOrNull((element) => element.event.collidesWith(event));
      var position = collide == null ? 0 : (collide.position + 1);
      positions.add(_EventListPosition(event, position));
    }
    return positions;
  }
}
