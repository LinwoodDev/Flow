import 'package:flow/helpers/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/helpers/date_time.dart';

import '../../cubits/flow.dart';
import 'appointment.dart';

class CalendarListTile extends StatelessWidget {
  final Appointment appointment;
  final String source;
  final DateTime? date;
  final VoidCallback onRefresh;

  const CalendarListTile({
    super.key,
    required this.appointment,
    required this.source,
    this.date,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final timeFormatter = DateFormat.Hm(locale);
    final start =
        appointment.start?.onlyDate() == date && appointment.start != null
            ? timeFormatter.format(appointment.start!)
            : '';
    final end = appointment.end?.onlyDate() == date && appointment.end != null
        ? timeFormatter.format(appointment.end!)
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
      title: Text(appointment.name),
      subtitle: Text(range),
      leading: Icon(appointment.status.getIcon(),
          color: appointment.status.getColor()),
      onTap: () => showDialog(
          context: context,
          builder: (context) => AppointmentDialog(
              appointment: appointment,
              event: const Event(),
              source: source)).then((_) => onRefresh()),
      trailing: FutureBuilder<bool?>(
        future: Future.value(context
            .read<FlowCubit>()
            .getSource(source)
            .note
            ?.notesDone(appointment.id)),
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
