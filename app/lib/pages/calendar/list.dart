import 'package:flow/helpers/event.dart';
import 'package:flow/pages/calendar/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/helpers/date_time.dart';

class CalendarListView extends StatefulWidget {
  final List<MapEntry<Event, String>> events;
  final VoidCallback onRefresh;

  const CalendarListView(
      {super.key, required this.events, required this.onRefresh});

  @override
  State<CalendarListView> createState() => _CalendarListViewState();
}

class _CalendarListViewState extends State<CalendarListView> {
  final GlobalKey _todayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToday());
  }

  void _scrollToday() {
    Scrollable.ensureVisible(_todayKey.currentContext!,
        duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().onlyDate();
    var days = widget.events.expand((e) {
      final start = e.key.start?.onlyDate();
      final end = e.key.end?.onlyDate();
      if (start != null && end != null) {
        return List.generate(end.difference(start).inDays + 1,
            (index) => DateTime(start.year, start.month, start.day + index));
      } else if (start != null) {
        return <DateTime>[start];
      } else if (end != null) {
        return <DateTime>[end];
      } else {
        return <DateTime>[];
      }
    }).toList()
      ..add(today);
    days = days.toSet().toList();
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: List.generate(
              days.length,
              (index) => _CalendarListDayView(
                  date: days[index],
                  onRefresh: widget.onRefresh,
                  key: days[index] == today ? _todayKey : null,
                  events: widget.events.where((element) {
                    final start = element.key.start;
                    final end = element.key.end;
                    return start?.onlyDate() == days[index] ||
                        end?.onlyDate() == days[index] ||
                        start != null &&
                            end != null &&
                            start.isBefore(days[index]) &&
                            end.isAfter(days[index]);
                  }).toList()),
            ),
          ),
        ),
      ),
    );
  }
}

class _CalendarListDayView extends StatelessWidget {
  final DateTime date;
  final List<MapEntry<Event, String>> events;
  final VoidCallback onRefresh;

  const _CalendarListDayView(
      {super.key,
      required this.date,
      required this.events,
      required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final dateFormatter = DateFormat.yMMMMd(locale);
    final timeFormatter = DateFormat.Hm(locale);
    return Column(
      children: [
        if (date == DateTime.now().onlyDate())
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Icon(
              Icons.today_outlined,
              color: Theme.of(context).primaryColor,
              size: 64,
            ),
          ),
        Text(
          dateFormatter.format(date),
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 16),
        Column(
            children: events.map((e) {
          final event = e.key;
          final start = event.start?.onlyDate() == date && event.start != null
              ? timeFormatter.format(event.start!)
              : '';
          final end = event.end?.onlyDate() == date && event.end != null
              ? timeFormatter.format(event.end!)
              : '';
          String range;
          if (start == '' && end == '') {
            range = '';
          } else if (start == '') {
            range = ' - $end';
          } else if (end == '') {
            range = '$start -';
          } else {
            range = '$start - $end';
          }
          return ListTile(
            title: Text(e.key.name),
            subtitle: Text(range),
            leading:
                Icon(e.key.status.getIcon(), color: e.key.status.getColor()),
            onTap: () => showDialog(
                    context: context,
                    builder: (context) =>
                        EventDialog(event: event, source: e.value))
                .then((_) => onRefresh()),
          );
        }).toList()),
        const SizedBox(height: 32),
      ],
    );
  }
}
