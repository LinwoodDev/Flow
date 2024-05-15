import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/calendar/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lib5/lib5.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flow_api/models/model.dart';

import '../../cubits/settings.dart';
import 'filter.dart';
import 'tile.dart';

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
  int _month = 0, _year = 0, _startOfWeek = 0;
  late final DateTime _now;
  late Future<List<List<SourcedConnectedModel<CalendarItem, Event?>>>>
      _appointments;

  @override
  void initState() {
    _now = DateTime.now();
    super.initState();
    _cubit = context.read<FlowCubit>();
    _month = _now.month;
    _year = _now.year;
    _startOfWeek = context.read<SettingsCubit>().state.startOfWeek;

    _appointments = _fetchCalendarItems();
  }

  DateTime get _date => DateTime(
        _year,
        _month,
        1,
        _now.hour,
        _now.minute,
        _now.second,
      ).getStartOfWeek(_startOfWeek);

  int _getDaysInView() => 6 * 7;

  Future<List<List<SourcedConnectedModel<CalendarItem, Event?>>>>
      _fetchCalendarItems() async {
    if (!mounted) {
      return [];
    }

    var sources = _cubit.getCurrentServicesMap();
    if (widget.filter.source != null) {
      sources = {
        widget.filter.source!: _cubit.getService(widget.filter.source!)
      };
    }
    final days = _getDaysInView();
    final appointments = <List<SourcedConnectedModel<CalendarItem, Event?>>>[
      for (int i = 0; i < days; i++) []
    ];
    final date = _date;
    for (final source in sources.entries) {
      for (int i = 0; i < days; i++) {
        final fetchedDay = await source.value.calendarItem?.getCalendarItems(
          date: date.addDays(i),
          status: EventStatus.values
              .where(
                  (element) => !widget.filter.hiddenStatuses.contains(element))
              .toList(),
          search: widget.search,
          eventId: widget.filter.event,
          groupId: widget.filter.group,
          placeId: widget.filter.place,
        );
        if (fetchedDay == null) continue;
        appointments[i]
            .addAll(fetchedDay.map((e) => SourcedModel(source.key, e)));
      }
    }
    return appointments;
  }

  void _addMonth(int add) {
    setState(() {
      final dateTime = DateTime(_year, _month + add, 1);
      _month = dateTime.month;
      _year = dateTime.year;
      _appointments = _fetchCalendarItems();
    });
  }

  void _refresh() => setState(() {
        _appointments = _fetchCalendarItems();
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
    final locale = Localizations.localeOf(context).languageCode;
    return LayoutBuilder(
      builder: (context, constraints) => CreateEventScaffold(
        onCreated: _refresh,
        event: widget.filter.sourceEvent,
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
                  child: const PhosphorIcon(PhosphorIconsLight.caretLeft),
                ),
                Row(
                  children: [
                    IconButton(
                      icon:
                          const PhosphorIcon(PhosphorIconsLight.calendarBlank),
                      isSelected: _year == DateTime.now().year &&
                          _month == DateTime.now().month,
                      onPressed: () {
                        setState(() {
                          final now = DateTime.now();
                          _month = now.month;
                          _year = now.year;
                          _appointments = _fetchCalendarItems();
                        });
                      },
                    ),
                    GestureDetector(
                      child: Text(
                        DateFormat.yMMMM(locale).format(_date.addDays(7)),
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
                            _appointments = _fetchCalendarItems();
                          });
                        }
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => _addMonth(1),
                  child: const PhosphorIcon(PhosphorIconsLight.caretRight),
                ),
              ],
            ),
            const Divider(),
          ]),
          Expanded(
            child: FutureBuilder<
                    List<List<SourcedConnectedModel<CalendarItem, Event?>>>>(
                future: _appointments,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final appointments = snapshot.data!;
                  return SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: appointments.length + 7,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: constraints.maxWidth / 7 / 100,
                      ),
                      itemBuilder: (context, index) {
                        if (index < 7) {
                          return LayoutBuilder(builder: (context, constraints) {
                            final current = _date
                                .getStartOfWeek(_startOfWeek)
                                .addDays(index);
                            var text = DateFormat.EEEE(locale).format(
                              current,
                            );
                            if (constraints.maxWidth < 150) {
                              text = DateFormat.E(locale).format(
                                current,
                              );
                            }
                            return Center(
                              child: Text(
                                text,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: current.weekday == _now.weekday
                                          ? Theme.of(context).primaryColor
                                          : null,
                                    ),
                              ),
                            );
                          });
                        }
                        final current = index - 7;
                        final day = _date
                            .getStartOfWeek(_startOfWeek)
                            .addDays(current - 7);
                        return InkWell(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => CalendarDayDialog(
                                date: day,
                                appointments: appointments[current],
                                event: widget.filter.sourceEvent,
                              ),
                            );
                            _refresh();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  day.day.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: day.isSameDay(DateTime.now())
                                            ? Theme.of(context).primaryColor
                                            : day.month != _month
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.5)
                                                : null,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                if (appointments[current].isNotEmpty)
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

class CalendarDayDialog extends StatelessWidget {
  final DateTime date;
  final List<SourcedConnectedModel<CalendarItem, Event?>> appointments;
  final SourcedModel<Multihash>? event;

  const CalendarDayDialog({
    super.key,
    required this.date,
    required this.appointments,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: date.isSameDay(DateTime.now())
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat.yMMMMEEEEd(Localizations.localeOf(context).languageCode)
                .format(date),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
            tooltip: AppLocalizations.of(context).createEvent,
            onPressed: () async {
              await showCalendarCreate(
                context: context,
                event: event,
                time: date,
              );
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (appointments.isEmpty)
            Center(
              child: Text(AppLocalizations.of(context).noEvents),
            )
          else
            ...appointments.map(
              (e) => CalendarListTile(
                key: ValueKey('${e.source}@${e.main.id}'),
                eventItem: e,
                date: date,
                onRefresh: () => Navigator.of(context).pop(),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).close),
        ),
      ],
    );
  }
}
