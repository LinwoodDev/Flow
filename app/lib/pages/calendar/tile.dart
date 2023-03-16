import 'package:flow/helpers/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/helpers/date_time.dart';

import '../../cubits/flow.dart';
import 'event.dart';

class CalendarListTile extends StatelessWidget {
  final Event event;
  final String source;
  final DateTime? date;
  final VoidCallback onRefresh;

  const CalendarListTile({
    super.key,
    required this.event,
    required this.source,
    this.date,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final timeFormatter = DateFormat.Hm(locale);
    final start =
        event.time.start?.onlyDate() == date && event.time.start != null
            ? timeFormatter.format(event.time.start!)
            : '';
    final end = event.time.end?.onlyDate() == date && event.time.end != null
        ? timeFormatter.format(event.time.end!)
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
      title: Text(event.name),
      subtitle: Text(range),
      leading: Icon(event.status.getIcon(), color: event.status.getColor()),
      onTap: () => showDialog(
              context: context,
              builder: (context) => EventDialog(event: event, source: source))
          .then((_) => onRefresh()),
      trailing: FutureBuilder<bool?>(
        future: Future.value(context
            .read<FlowCubit>()
            .getSource(source)
            .note
            ?.notesDone(event.id)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Icon(
              snapshot.data!
                  ? Icons.check_circle_outline_outlined
                  : Icons.circle_outlined,
              color: snapshot.data ?? false
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
