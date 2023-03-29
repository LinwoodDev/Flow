import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/appointment/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/model.dart';

import '../events/appointment.dart';
import '../events/page.dart';
import 'filter.dart';
import '../../helpers/event.dart';
import 'page.dart';

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
  late Future<List<SourcedConnectedModel<Appointment, Event>>> _dates;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _dates = _fetchDates();
  }

  Future<List<SourcedConnectedModel<Appointment, Event>>> _fetchDates() async {
    if (!mounted) return [];

    var sources = _cubit.getCurrentServicesMap();
    if (widget.filter.source != null) {
      sources = {
        widget.filter.source!: _cubit.getSource(widget.filter.source!)
      };
    }
    final dates = <SourcedConnectedModel<Appointment, Event>>[];
    for (final source in sources.entries) {
      final fetched = await source.value.appointmentEvent?.getAppointments(
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
      if (fetched == null) continue;
      dates.addAll(fetched.map((date) => SourcedModel(source.key, date)));
    }
    return dates;
  }

  void _addDay(int add) {
    setState(() {
      _date = _date.add(Duration(days: add));
      _dates = _fetchDates();
    });
  }

  void _refresh() => setState(() {
        _dates = _fetchDates();
      });

  @override
  void didUpdateWidget(covariant CalendarDayView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filter != widget.filter) {
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CreateEventScaffold(
      onCreated: _refresh,
      child: LayoutBuilder(
          builder: (context, constraints) => ListView(children: [
                Align(
                  alignment: Alignment.center,
                  child: CalendarFilterView(
                    initialFilter: widget.filter,
                    onChanged: (value) {
                      _refresh();
                      widget.onFilterChanged(value);
                    },
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
                              _dates = _fetchDates();
                            });
                          },
                        ),
                        GestureDetector(
                          child: Text(
                            DateFormat.yMMMMd(Localizations.localeOf(context)
                                    .languageCode)
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
                                _dates = _fetchDates();
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
                FutureBuilder<List<SourcedConnectedModel<Appointment, Event>>>(
                    future: _dates,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleDayList(
                          appointments: snapshot.data!,
                          onChanged: _refresh,
                          current: _date,
                          maxWidth: constraints.maxWidth,
                        ),
                      );
                    }),
              ])),
    );
  }
}

class _EventListPosition {
  final SourcedConnectedModel<Appointment, Event> appointment;
  final int position;

  _EventListPosition(this.appointment, this.position);
}

class SingleDayList extends StatelessWidget {
  final List<SourcedConnectedModel<Appointment, Event>> appointments;
  final VoidCallback onChanged;
  final DateTime current;
  final double maxWidth;

  static const _hourHeight = 100.0;
  static const _dividerHeight = 4.0;
  static const _positionWidth = 200.0;

  const SingleDayList({
    super.key,
    required this.appointments,
    required this.onChanged,
    required this.current,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final positions = _getEventListPositions(appointments);
    final maxPosition =
        positions.isEmpty ? 0 : positions.map((e) => e.position).reduce(max);
    var currentPosWidth = max(maxWidth / (maxPosition + 2), _positionWidth);
    if (currentPosWidth.isInfinite) {
      currentPosWidth = _positionWidth;
    }
    return SizedBox(
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

            await showCalendarCreate(context: context, time: dateTime);
            onChanged();
          }),
          for (final position in positions)
            Builder(builder: (context) {
              double top = 0, height;
              final appointment = position.appointment.main;
              if (appointment.start?.isSameDay(current) ?? false) {
                top = (appointment.start?.hour ?? 0) * _hourHeight +
                    (appointment.start?.minute ?? 0) / 60 * _hourHeight;
              }
              if (appointment.end?.isSameDay(current) ?? false) {
                height = (appointment.end?.hour ?? 23) * _hourHeight +
                    (appointment.end?.minute ?? 59) / 60 * _hourHeight -
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
                  color: appointment.status.getColor().withAlpha(
                        220,
                      ),
                  child: InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AppointmentDialog(
                        appointment: appointment,
                        event: SourcedModel(position.appointment.source,
                            position.appointment.sub),
                      ),
                    ).then((value) => onChanged()),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            appointment.description,
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
    );
  }

  List<_EventListPosition> _getEventListPositions(
      List<SourcedConnectedModel<Appointment, Event>> dates) {
    final positions = <_EventListPosition>[];
    for (final date in dates) {
      final collide = positions.reversed.firstWhereOrNull(
          (element) => element.appointment.main.collidesWith(date.main));
      var position = collide == null ? 0 : (collide.position + 1);
      positions.add(_EventListPosition(date, position));
    }
    return positions;
  }
}
