import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/calendar/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';

import 'filter.dart';
import '../../helpers/event.dart';

class CalendarMonthView extends StatefulWidget {
  final CalendarFilter filter;
  final String search;
  final ValueChanged<CalendarFilter> onFilterChanged;

  const CalendarMonthView({
    super.key,
    required this.filter,
    this.search = '',
    required this.onFilterChanged,
  });

  @override
  State<CalendarMonthView> createState() => _CalendarMonthViewState();
}

class _CalendarMonthViewState extends State<CalendarMonthView> {
  late final FlowCubit _cubit;
  int _month = 0, _year = 0;
  late Future<List<List<MapEntry<String, Event>>>> _events;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _events = _fetchEvents();
    final now = DateTime.now();
    _month = now.month;
    _year = now.year;
  }

  DateTime get _date => DateTime(_year, _month, 1);

  Future<List<List<MapEntry<String, Event>>>> _fetchEvents() async {
    if (!mounted) return [];

    var sources = _cubit.getCurrentServicesMap();
    if (widget.filter.source != null) {
      sources = {
        widget.filter.source!: _cubit.getSource(widget.filter.source!)
      };
    }
    final days = _date.getDaysInMonth();
    final events = <List<MapEntry<String, Event>>>[
      for (int i = 0; i < days; i++) []
    ];
    for (final source in sources.entries) {
      for (int i = 0; i < days; i++) {
        final fetchedDay = await source.value.event.getEvents(
          date: _date.addDays(i),
          status: EventStatus.values
              .where(
                  (element) => !widget.filter.hiddenStatuses.contains(element))
              .toList(),
          search: widget.search,
          groupId:
              source.key == widget.filter.source ? widget.filter.group : null,
          placeId:
              source.key == widget.filter.source ? widget.filter.place : null,
        );
        events[i].addAll(fetchedDay.map((e) => MapEntry(source.key, e)));
      }
    }
    return events;
  }

  void _addMonth(int add) {
    setState(() {
      final dateTime = DateTime(_year, _month + add, 1);
      _month = dateTime.month;
      _year = dateTime.year;
      _events = _fetchEvents();
    });
  }

  void _refresh() => setState(() {
        _events = _fetchEvents();
      });

  @override
  void didUpdateWidget(covariant CalendarMonthView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filter != widget.filter) {
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => CreateEventScaffold(
        onCreated: (p0) => _refresh,
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
                  onPressed: () => _addMonth(-1),
                  child: const Icon(Icons.chevron_left),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.today_outlined),
                      isSelected: _date.isSameDay(DateTime.now()),
                      onPressed: () {
                        setState(() {
                          final now = DateTime.now();
                          _month = now.month;
                          _year = now.year;
                          _events = _fetchEvents();
                        });
                      },
                    ),
                    GestureDetector(
                      child: Text(
                        "$_month - $_year",
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
                            _month = date.month;
                            _year = date.year;
                            _events = _fetchEvents();
                          });
                        }
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => _addMonth(1),
                  child: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const Divider(),
          ]),
          Expanded(
            child: FutureBuilder<List<List<MapEntry<String, Event>>>>(
                future: _events,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final events = snapshot.data!;
                  final emptyPadding = _date.weekday;
                  return SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: events.length + emptyPadding + 7,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: constraints.maxWidth / 7 / 100,
                      ),
                      itemBuilder: (context, index) {
                        if (index < 7) {
                          return LayoutBuilder(builder: (context, constraints) {
                            final current =
                                _date.startOfWeek.addDays(index + 1);
                            var text = DateFormat.EEEE().format(
                              current,
                            );
                            if (constraints.maxWidth < 150) {
                              text = DateFormat.E().format(
                                current,
                              );
                            }
                            return Center(
                              child: Text(
                                text,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            );
                          });
                        }
                        var current = index - 7;
                        if (current < emptyPadding) {
                          return Container();
                        }
                        current = current - emptyPadding;
                        final day = _date.addDays(current);
                        return InkWell(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                day.day.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      color: day.isSameDay(DateTime.now())
                                          ? Theme.of(context).primaryColor
                                          : null,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              if (events[current].isNotEmpty)
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
