import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/item/model.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/model.dart';

import 'item.dart';
import 'filter.dart';
import '../../helpers/event.dart';
import 'page.dart';

class AutoScrollDragTarget extends StatefulWidget {
  final VoidCallback onAction;
  final Widget child;

  const AutoScrollDragTarget({
    super.key,
    required this.onAction,
    required this.child,
  });

  @override
  State<AutoScrollDragTarget> createState() => _AutoScrollDragTargetState();
}

class _AutoScrollDragTargetState extends State<AutoScrollDragTarget> {
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Object>(
      builder: (context, candidateData, rejectedData) => widget.child,
      onMove: (_) {
        if (_timer != null && _timer!.isActive) return;
        _timer = Timer(const Duration(seconds: 1), widget.onAction);
      },
      onLeave: (_) {
        _timer?.cancel();
      },
    );
  }
}

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
  late Future<List<SourcedConnectedModel<CalendarItem, Event?>>> _dates;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _dates = _fetchDates();
  }

  Future<List<SourcedConnectedModel<CalendarItem, Event?>>>
  _fetchDates() async {
    if (!mounted) return [];

    var sources = _cubit.getCurrentServicesMap();
    if (widget.filter.source != null) {
      sources = {
        widget.filter.source!: _cubit.getService(widget.filter.source!),
      };
    }
    final dates = <SourcedConnectedModel<CalendarItem, Event?>>[];
    for (final source in sources.entries) {
      final fetched = await source.value.calendarItem?.getCalendarItems(
        date: _date,
        status: EventStatus.values
            .where((element) => !widget.filter.hiddenStatuses.contains(element))
            .toList(),
        search: widget.search,
        groupIds: widget.filter.groups,
        eventId: widget.filter.event,
        resourceIds: widget.filter.resources,
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
      event: widget.filter.sourceEvent,
      child: LayoutBuilder(
        builder: (context, constraints) => ListView(
          children: [
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
                AutoScrollDragTarget(
                  onAction: () => _addDay(-1),
                  child: ElevatedButton(
                    onPressed: () => _addDay(-1),
                    child: const PhosphorIcon(PhosphorIconsLight.caretLeft),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const PhosphorIcon(
                        PhosphorIconsLight.calendarBlank,
                      ),
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
                        DateFormat.yMMMMd(
                          Localizations.localeOf(context).languageCode,
                        ).format(_date),
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
                AutoScrollDragTarget(
                  onAction: () => _addDay(1),
                  child: ElevatedButton(
                    onPressed: () => _addDay(1),
                    child: const PhosphorIcon(PhosphorIconsLight.caretRight),
                  ),
                ),
              ],
            ),
            const Divider(),
            FutureBuilder<List<SourcedConnectedModel<CalendarItem, Event?>>>(
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
                    event: widget.filter.sourceEvent,
                    onReschedule: (item, start) async {
                      final service = _cubit.getService(item.source);
                      DateTime? end;
                      if (item.main.start != null && item.main.end != null) {
                        final duration = item.main.end!.difference(
                          item.main.start!,
                        );
                        end = start.add(duration);
                      }
                      final newItem = item.main.copyWith(
                        start: start,
                        end: end,
                      );
                      await service.calendarItem?.updateCalendarItem(newItem);
                      _refresh();
                    },
                    onResize: (item, start, end) async {
                      final service = _cubit.getService(item.source);
                      final newItem = item.main.copyWith(
                        start: start,
                        end: end,
                      );
                      await service.calendarItem?.updateCalendarItem(newItem);
                      _refresh();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EventListPosition {
  final SourcedConnectedModel<CalendarItem, Event?> appointment;
  final int position;

  _EventListPosition(this.appointment, this.position);
}

typedef RescheduleCallback =
    Future<void> Function(
      SourcedConnectedModel<CalendarItem, Event?> item,
      DateTime newStart,
    );

typedef ResizeCallback =
    Future<void> Function(
      SourcedConnectedModel<CalendarItem, Event?> item,
      DateTime newStart,
      DateTime newEnd,
    );

class SingleDayList extends StatefulWidget {
  final List<SourcedConnectedModel<CalendarItem, Event?>> appointments;
  final VoidCallback onChanged;
  final RescheduleCallback? onReschedule;
  final ResizeCallback? onResize;
  final DateTime current;
  final double maxWidth;
  final SourcedModel<Uint8List>? event;

  static const _hourHeight = 100.0;
  static const _dividerHeight = 4.0;
  static const _positionWidth = 200.0;

  const SingleDayList({
    super.key,
    required this.appointments,
    required this.onChanged,
    this.onReschedule,
    this.onResize,
    required this.current,
    required this.maxWidth,
    this.event,
  });

  @override
  State<SingleDayList> createState() => _SingleDayListState();
}

class _SingleDayListState extends State<SingleDayList> {
  late final Timer _minuteTimer;
  double? _currentHeight;
  final Map<String, ({double top, double height})> _resizingItems = {};

  @override
  void initState() {
    super.initState();
    _minuteTimer = Timer.periodic(const Duration(seconds: 1), _tick);
    _tick(_minuteTimer);
  }

  @override
  void dispose() {
    super.dispose();
    _minuteTimer.cancel();
  }

  void _tick(Timer timer) {
    final now = DateTime.now();
    final nextHeight =
        now.hour * SingleDayList._hourHeight +
        now.minute * SingleDayList._hourHeight / 60.0;
    if (nextHeight != _currentHeight && now.isSameDay(widget.current)) {
      setState(() {
        _currentHeight = nextHeight;
      });
    }
  }

  @override
  void didUpdateWidget(covariant SingleDayList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.appointments != widget.appointments ||
        oldWidget.event != widget.event) {
      setState(() {});
    }
  }

  Future<void> _reschedule(
    SourcedConnectedModel<CalendarItem, Event?> item,
    double top,
  ) async {
    if (widget.onReschedule == null) return;
    var minutes = ((top / SingleDayList._hourHeight) % 1 * 60).floor();
    minutes = (minutes / 5).floor() * 5;
    // Calculate current time
    final dateTime = DateTime(
      widget.current.year,
      widget.current.month,
      widget.current.day,
      (top / SingleDayList._hourHeight).floor(),
      minutes,
    );
    await widget.onReschedule!(item, dateTime);
  }

  Future<void> _resize(
    SourcedConnectedModel<CalendarItem, Event?> item,
    double top,
    double height,
  ) async {
    if (widget.onResize == null) return;
    var bottom = top + height;
    var startMinutes = ((top / SingleDayList._hourHeight) % 1 * 60).floor();
    startMinutes = (startMinutes / 5).floor() * 5;
    var endMinutes = ((bottom / SingleDayList._hourHeight) % 1 * 60).floor();
    endMinutes = (endMinutes / 5).floor() * 5;
    // Calculate current time
    final start = DateTime(
      widget.current.year,
      widget.current.month,
      widget.current.day,
      (top / SingleDayList._hourHeight).floor(),
      startMinutes,
    );
    final end = DateTime(
      widget.current.year,
      widget.current.month,
      widget.current.day,
      (bottom / SingleDayList._hourHeight).floor(),
      endMinutes,
    );
    await widget.onResize!(item, start, end);
  }

  @override
  Widget build(BuildContext context) {
    final positions = _getEventListPositions(widget.appointments);
    final maxPosition = positions.isEmpty
        ? 0
        : positions.map((e) => e.position).reduce(max);
    var currentPosWidth = max(
      widget.maxWidth / (maxPosition + 2),
      SingleDayList._positionWidth,
    );
    if (currentPosWidth.isInfinite) {
      currentPosWidth = SingleDayList._positionWidth;
    }
    return SizedBox(
      height: 24 * SingleDayList._hourHeight + SingleDayList._dividerHeight,
      width: currentPosWidth * (maxPosition + 2),
      child: Stack(
        children: [
          Positioned.fill(
            child: DragTarget<SourcedConnectedModel<CalendarItem, Event?>>(
              builder: (context, candidateData, rejectedData) {
                return GestureDetector(
                  onTapUp: (details) async {
                    var minutes =
                        ((details.localPosition.dy /
                                    SingleDayList._hourHeight) %
                                1 *
                                60)
                            .floor();
                    minutes = (minutes / 5).floor() * 5;
                    // Calculate current time
                    final dateTime = DateTime(
                      widget.current.year,
                      widget.current.month,
                      widget.current.day,
                      (details.localPosition.dy / SingleDayList._hourHeight)
                          .floor(),
                      minutes,
                    );

                    await showCalendarCreate(
                      context: context,
                      time: dateTime,
                      event: widget.event,
                    );
                    widget.onChanged();
                  },
                );
              },
              onAcceptWithDetails: (details) {
                final renderBox = context.findRenderObject() as RenderBox;
                final localOffset = renderBox.globalToLocal(details.offset);
                _reschedule(details.data, localOffset.dy);
              },
            ),
          ),
          for (final position in positions)
            Builder(
              builder: (context) {
                double top = 0, height;
                final appointment = position.appointment.main;
                if (appointment.start?.isSameDay(widget.current) ?? false) {
                  top =
                      (appointment.start?.hour ?? 0) *
                          SingleDayList._hourHeight +
                      (appointment.start?.minute ?? 0) /
                          60 *
                          SingleDayList._hourHeight;
                }
                if (appointment.end?.isSameDay(widget.current) ?? false) {
                  height =
                      (appointment.end?.hour ?? 23) *
                          SingleDayList._hourHeight +
                      (appointment.end?.minute ?? 59) /
                          60 *
                          SingleDayList._hourHeight -
                      top;
                } else {
                  height = 24 * SingleDayList._hourHeight - top;
                }

                final key =
                    '${position.appointment.source}@${position.appointment.main.id}';
                if (_resizingItems.containsKey(key)) {
                  height = max(
                    _resizingItems[key]!.height,
                    SingleDayList._hourHeight / 4,
                  ); // Min 15 mins
                  top = _resizingItems[key]!.top;
                }

                final child = Stack(
                  children: [
                    Positioned.fill(
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: appointment.status.getColor().withAlpha(220),
                        child: InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => CalendarItemDialog(
                              item: appointment,
                              event: position.appointment.sub,
                              source: position.appointment.source,
                            ),
                          ).then((value) => widget.onChanged()),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appointment.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
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
                    ),
                    if (widget.onResize != null) ...[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 10,
                        child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            final current =
                                _resizingItems[key] ??
                                (top: top, height: height);
                            setState(() {
                              _resizingItems[key] = (
                                top: current.top,
                                height: max(
                                  current.height + details.delta.dy,
                                  10,
                                ),
                              );
                            });
                          },
                          onVerticalDragEnd: (details) {
                            final current =
                                _resizingItems[key] ??
                                (top: top, height: height);
                            _resize(
                              position.appointment,
                              current.top,
                              current.height,
                            );
                            setState(() {
                              _resizingItems.remove(key);
                            });
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.resizeUpDown,
                            child: Container(color: Colors.transparent),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 10,
                        child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            final current =
                                _resizingItems[key] ??
                                (top: top, height: height);
                            setState(() {
                              _resizingItems[key] = (
                                top: current.top + details.delta.dy,
                                height: max(
                                  current.height - details.delta.dy,
                                  10,
                                ),
                              );
                            });
                          },
                          onVerticalDragEnd: (details) {
                            final current =
                                _resizingItems[key] ??
                                (top: top, height: height);
                            _resize(
                              position.appointment,
                              current.top,
                              current.height,
                            );
                            setState(() {
                              _resizingItems.remove(key);
                            });
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.resizeUpDown,
                            child: Container(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
                return Positioned(
                  top: top,
                  height: height,
                  left: currentPosWidth * position.position,
                  width: currentPosWidth,
                  child:
                      LongPressDraggable<
                        SourcedConnectedModel<CalendarItem, Event?>
                      >(
                        data: position.appointment,
                        feedback: SizedBox(
                          width: currentPosWidth,
                          height: height,
                          child: child,
                        ),
                        childWhenDragging: Opacity(opacity: 0.5, child: child),
                        child: child,
                      ),
                );
              },
            ),
          for (int i = 0; i < 24; i++)
            Positioned(
              top: i * SingleDayList._hourHeight,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  const Flexible(child: Divider()),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat.Hm(
                      Localizations.localeOf(context).languageCode,
                    ).format(DateTime(0, 0, 0, i)),
                  ),
                  const SizedBox(width: 8),
                  const Flexible(child: Divider()),
                ],
              ),
            ),
          if (_currentHeight != null)
            Positioned(
              top: _currentHeight!,
              left: 0,
              right: 0,
              child: Divider(
                color: Theme.of(context).colorScheme.secondary,
                thickness: 2,
              ),
            ),
        ],
      ),
    );
  }

  List<_EventListPosition> _getEventListPositions(
    List<SourcedConnectedModel<CalendarItem, Event?>> dates,
  ) {
    final positions = <_EventListPosition>[];
    for (final date in dates) {
      final collide = positions.reversed.firstWhereOrNull(
        (element) => element.appointment.main.collidesWith(date.main),
      );
      var position = collide == null ? 0 : (collide.position + 1);
      positions.add(_EventListPosition(date, position));
    }
    return positions;
  }
}
