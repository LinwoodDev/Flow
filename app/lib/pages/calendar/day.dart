import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/calendar/event.dart';
import 'package:flow/pages/calendar/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';

import 'filter.dart';
import '../../helpers/event.dart';

class CalendarDayView extends StatefulWidget {
  final CalendarFilter filter;
  final String search;
  final ValueChanged<CalendarFilter> onFilterChanged;

  const CalendarDayView({
    super.key,
    required this.filter,
    this.search = '',
    required this.onFilterChanged,
  });

  @override
  State<CalendarDayView> createState() => _CalendarDayViewState();
}

class _CalendarDayViewState extends State<CalendarDayView> {
  late final FlowCubit _cubit;
  DateTime _date = DateTime.now();
  late Future<List<MapEntry<String, Event>>> _events;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _events = _fetchEvents();
  }

  Future<List<MapEntry<String, Event>>> _fetchEvents() async {
    if (!mounted) return [];

    var sources = _cubit.getCurrentServicesMap();
    if (widget.filter.source != null) {
      sources = {
        widget.filter.source!: _cubit.getSource(widget.filter.source!)
      };
    }
    final events = <MapEntry<String, Event>>[];
    for (final source in sources.entries) {
      final fetched = await source.value.event.getEvents(
        date: _date,
        status: EventStatus.values
            .where((element) => !widget.filter.hiddenStatuses.contains(element))
            .toList(),
        search: widget.search,
        groupId:
            source.key == widget.filter.source ? widget.filter.group : null,
        placeId:
            source.key == widget.filter.source ? widget.filter.place : null,
      );
      events.addAll(fetched.map((event) => MapEntry(source.key, event)));
    }
    return events;
  }

  void _addDay(int add) {
    setState(() {
      _date = _date.add(Duration(days: add));
      _events = _fetchEvents();
    });
  }

  void _refresh() => setState(() {
        _events = _fetchEvents();
      });

  @override
  Widget build(BuildContext context) {
    return CreateEventScaffold(
      onCreated: (p0) => _refresh,
      child: ListView(children: [
        Align(
          alignment: Alignment.center,
          child: CalendarFilterView(
            initialFilter: widget.filter,
            onChanged: widget.onFilterChanged,
            past: false,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () => _addDay(-1),
              child: const Icon(Icons.chevron_left),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.today_outlined),
                  isSelected: _date.isSameDay(DateTime.now()),
                  onPressed: () {
                    setState(() {
                      _date = DateTime.now();
                      _events = _fetchEvents();
                    });
                  },
                ),
                GestureDetector(
                  child: Text(
                    DateFormat.yMMMMd(
                            Localizations.localeOf(context).languageCode)
                        .format(_date),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
                      lastDate: _date.addYears(200),
                    );
                    if (date != null) {
                      setState(() {
                        _date = date;
                        _events = _fetchEvents();
                      });
                    }
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => _addDay(1),
              child: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const Divider(),
        FutureBuilder<List<MapEntry<String, Event>>>(
            future: _events,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleDayList(
                events: snapshot.data!,
                onChanged: _refresh,
                current: _date,
              );
            }),
      ]),
    );
  }
}

class _EventListPosition {
  final String source;
  final Event event;
  final int position;

  _EventListPosition(this.event, this.source, this.position);
}

class SingleDayList extends StatelessWidget {
  final List<MapEntry<String, Event>> events;
  final VoidCallback onChanged;
  final DateTime current;

  static const _hourHeight = 100.0;
  static const _dividerHeight = 4.0;
  static const _positionWidth = 200.0;

  const SingleDayList({
    super.key,
    required this.events,
    required this.onChanged,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final positions = _getEventListPositions(events);
    final maxPosition =
        positions.isEmpty ? 0 : positions.map((e) => e.position).reduce(max);
    return LayoutBuilder(builder: (context, constraints) {
      final currentPosWidth =
          max(constraints.maxWidth / (maxPosition + 2), _positionWidth);
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 24 * _hourHeight + _dividerHeight,
          width: currentPosWidth * (maxPosition + 2),
          child: Stack(
            children: [
              GestureDetector(onTapUp: (details) async {
                var minutes =
                    ((details.localPosition.dy / _hourHeight) % 1 * 60).floor();
                minutes = (minutes / 5).floor() * 5;
                // Calculate current time
                final dateTime = DateTime(
                  current.year,
                  current.month,
                  current.day,
                  (details.localPosition.dy / _hourHeight).floor(),
                  minutes,
                );

                await showDialog(
                    context: context,
                    builder: (context) => EventDialog(
                          event: Event(
                            start: dateTime,
                            end: dateTime.add(const Duration(hours: 1)),
                          ),
                        ));
                onChanged();
              }),
              for (final position in positions)
                Builder(builder: (context) {
                  double top = 0, height;
                  if (position.event.start?.isSameDay(current) ?? false) {
                    top = (position.event.start?.hour ?? 0) * _hourHeight +
                        (position.event.start?.minute ?? 0) / 60 * _hourHeight;
                  }
                  if (position.event.end?.isSameDay(current) ?? false) {
                    height = (position.event.end?.hour ?? 23) * _hourHeight +
                        (position.event.end?.minute ?? 59) / 60 * _hourHeight -
                        top;
                  } else {
                    height = 24 * _hourHeight - top;
                  }
                  return Positioned(
                    top: top,
                    height: height,
                    left: currentPosWidth * position.position,
                    width: currentPosWidth,
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => EventDialog(
                            event: position.event,
                            source: position.source,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                position.event.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                position.event.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
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
        ),
      );
    });
  }

  List<_EventListPosition> _getEventListPositions(
      List<MapEntry<String, Event>> events) {
    final positions = <_EventListPosition>[];
    for (final event in events) {
      final collide = positions.reversed.firstWhereOrNull(
          (element) => element.event.collidesWith(event.value));
      var position = collide == null ? 0 : (collide.position + 1);
      positions.add(_EventListPosition(event.value, event.key, position));
    }
    return positions;
  }
}
