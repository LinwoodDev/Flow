import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/calendar/filter.dart';
import 'package:flow/pages/calendar/list.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/event/model.dart';

import 'event.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

enum _CalendarView { list, day, week, month }

extension _CalendarViewExtension on _CalendarView {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case _CalendarView.list:
        return AppLocalizations.of(context)!.list;
      case _CalendarView.day:
        return AppLocalizations.of(context)!.day;
      case _CalendarView.week:
        return AppLocalizations.of(context)!.week;
      case _CalendarView.month:
        return AppLocalizations.of(context)!.month;
    }
  }

  IconData getIcon() {
    switch (this) {
      case _CalendarView.list:
        return Icons.list;
      case _CalendarView.day:
        return Icons.calendar_today;
      case _CalendarView.week:
        return Icons.calendar_view_week;
      case _CalendarView.month:
        return Icons.calendar_view_month;
    }
  }
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  _CalendarView _calendarView = _CalendarView.list;
  CalendarFilter _filter = const CalendarFilter();
  late Future<List<MapEntry<String, List<Event>>>> _future;

  @override
  void initState() {
    super.initState();
  }

  Future<List<MapEntry<String, List<Event>>>> _buildFuture() =>
      Future.wait(context
          .read<FlowCubit>()
          .getCurrentServicesMap()
          .entries
          .map((e) async => MapEntry(
              e.key,
              await e.value.event.getEvents(
                status: EventStatus.values
                    .where(
                        (element) => !_filter.hiddenStatuses.contains(element))
                    .toList(),
              ))));

  Future<void> _updateFuture([bool holdFuture = false]) async {
    if (holdFuture) {
      final events = await _buildFuture();
      setState(() {
        _future = Future.value(events);
      });
    } else {
      setState(() {
        _future = _buildFuture();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context)!.calendar,
      selected: "calendar",
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.filter_list_outlined),
          onPressed: () async {
            final filter = await showDialog<CalendarFilter>(
              context: context,
              builder: (context) => CalendarFilterDialog(
                initialFilter: _filter,
              ),
            );
            if (filter != null) {
              setState(() {
                _filter = filter;
              });
            }
          },
        ),
        PopupMenuButton<_CalendarView>(
          icon: Icon(_calendarView.getIcon()),
          initialValue: _calendarView,
          onSelected: (value) {
            setState(() {
              _calendarView = value;
            });
          },
          itemBuilder: (context) => _CalendarView.values
              .map((e) => PopupMenuItem(
                  value: e,
                  child: Row(
                    children: [
                      Icon(e.getIcon()),
                      const SizedBox(width: 8),
                      Text(e.getLocalizedName(context)),
                    ],
                  )))
              .toList(),
        ),
      ],
      body: BlocBuilder<FlowCubit, FlowState>(builder: (context, state) {
        _future = _buildFuture();
        return FutureBuilder<List<MapEntry<String, List<Event>>>>(
          future: _future,
          builder: (context, snapshot) {
            final events = snapshot.data
                    ?.expand((e) => e.value.map((i) => MapEntry(i, e.key)))
                    .toList() ??
                [];
            return StatefulBuilder(builder: (context, setInnerState) {
              return RefreshIndicator(
                  onRefresh: () => _updateFuture(true),
                  child: !snapshot.hasData
                      ? const Center(child: CircularProgressIndicator())
                      : CalendarListView(
                          events: events,
                          onRefresh: _updateFuture,
                        ));
            });
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
                context: context, builder: (context) => const EventDialog())
            .then((value) => _updateFuture()),
        label: Text(AppLocalizations.of(context)!.create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}
