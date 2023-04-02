import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/calendar/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/event/appointment/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/model.dart';

import 'day.dart';
import 'filter.dart';
import '../../helpers/event.dart';

class CalendarWeekView extends StatefulWidget {
  final CalendarFilter filter;
  final String search;
  final ValueChanged<CalendarFilter> onFilterChanged;

  const CalendarWeekView({
    super.key,
    required this.filter,
    this.search = '',
    required this.onFilterChanged,
  });

  @override
  State<CalendarWeekView> createState() => _CalendarWeekViewState();
}

class _CalendarWeekViewState extends State<CalendarWeekView> {
  late final FlowCubit _cubit;
  int _week = 0, _year = 0;
  late Future<List<List<SourcedConnectedModel<Appointment, Event?>>>>
      _appointments;
  final _columnScrollController = ScrollController(),
      _rowScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _appointments = _fetchAppointments();
    final now = DateTime.now();
    _week = now.week;
    _year = now.year;
  }

  DateTime get _date => DateTime(_year, 1, 1).addDays((_week - 1) * 7);

  Future<List<List<SourcedConnectedModel<Appointment, Event?>>>>
      _fetchAppointments() async {
    if (!mounted) return [];

    var sources = _cubit.getCurrentServicesMap();
    if (widget.filter.source != null) {
      sources = {
        widget.filter.source!: _cubit.getService(widget.filter.source!)
      };
    }
    final appointments = <List<SourcedConnectedModel<Appointment, Event?>>>[
      for (int i = 0; i < 7; i++) []
    ];
    for (final source in sources.entries) {
      for (int i = 0; i < 7; i++) {
        final fetchedDay = await source.value.appointment?.getAppointments(
          date: _date.addDays(i),
          status: EventStatus.values
              .where(
                  (element) => !widget.filter.hiddenStatuses.contains(element))
              .toList(),
          search: widget.search,
        );
        if (fetchedDay == null) continue;
        appointments[i]
            .addAll(fetchedDay.map((e) => SourcedModel(source.key, e)));
      }
    }
    return appointments;
  }

  void _addWeek(int add) {
    setState(() {
      final dateTime = DateTime(_year - 1, 12, 31).addDays((_week + add) * 7);
      _week = dateTime.week;
      _year = dateTime.year;
      _appointments = _fetchAppointments();
    });
  }

  void _refresh() => setState(() {
        _appointments = _fetchAppointments();
      });

  @override
  void didUpdateWidget(covariant CalendarWeekView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filter != widget.filter) {
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => CreateEventScaffold(
        onCreated: _refresh,
        child: Column(children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            CalendarFilterView(
              initialFilter: widget.filter,
              onChanged: (value) {
                _refresh();
                widget.onFilterChanged(value);
              },
              past: false,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _addWeek(-1),
                  child: const Icon(Icons.chevron_left),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.today_outlined),
                      isSelected: _date.year == DateTime.now().year &&
                          _date.week == DateTime.now().week - 1,
                      onPressed: () {
                        setState(() {
                          final now = DateTime.now();
                          _week = now.week;
                          _year = now.year;
                          _appointments = _fetchAppointments();
                        });
                      },
                    ),
                    GestureDetector(
                      child: Text(
                        "$_week - $_year",
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
                            _week = date.week;
                            _year = date.year;
                            _appointments = _fetchAppointments();
                          });
                        }
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => _addWeek(1),
                  child: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const Divider(),
          ]),
          Expanded(
            child: Scrollbar(
              controller: _rowScrollController,
              notificationPredicate: (notif) => notif.depth == 1,
              child: Scrollbar(
                controller: _columnScrollController,
                child: SingleChildScrollView(
                  controller: _columnScrollController,
                  child: SingleChildScrollView(
                    controller: _rowScrollController,
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder<
                            List<
                                List<
                                    SourcedConnectedModel<Appointment,
                                        Event?>>>>(
                        future: _appointments,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final events = snapshot.data!;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children:
                                events.asMap().entries.map<Widget>((entry) {
                              final date = _date.addDays(entry.key);
                              return Column(
                                children: [
                                  Text(
                                    date.day.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: date.isSameDay(DateTime.now())
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : null,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  SingleDayList(
                                    current: date,
                                    appointments: entry.value,
                                    onChanged: _refresh,
                                    maxWidth: constraints.maxWidth / 7,
                                  ),
                                ],
                              );
                            }).toList(),
                          );
                        }),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
