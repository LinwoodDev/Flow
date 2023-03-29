import 'package:flow/helpers/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/appointment/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/helpers/date_time.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../events/appointment.dart';

class CalendarListTile extends StatelessWidget {
  final SourcedConnectedModel<Appointment, Event> appointment;
  final DateTime? date;
  final VoidCallback onRefresh;

  const CalendarListTile({
    super.key,
    required this.appointment,
    this.date,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final timeFormatter = DateFormat.Hm(locale);
    final model = appointment.main;
    final start = model.start?.onlyDate() == date && model.start != null
        ? timeFormatter.format(model.start!)
        : '';
    final end = model.end?.onlyDate() == date && model.end != null
        ? timeFormatter.format(model.end!)
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
      title: Text(model.name),
      subtitle: Text(range),
      leading: Icon(model.status.getIcon(), color: model.status.getColor()),
      onTap: () => showDialog(
          context: context,
          builder: (context) => AppointmentDialog(
                appointment: appointment.main,
                event: appointment.subSourced,
              )).then((_) => onRefresh()),
      trailing: FutureBuilder<bool?>(
        future: Future.value(context
            .read<FlowCubit>()
            .getSource(appointment.source)
            .note
            ?.notesDone(appointment.sub.id)),
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
