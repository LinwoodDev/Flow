import 'package:flow/helpers/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/appointment/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/helpers/date_time.dart';
import 'package:shared/models/event/moment/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../events/appointment.dart';
import '../events/moment.dart';

class CalendarListTile extends StatelessWidget {
  final SourcedConnectedModel<EventItem, Event> eventItem;
  final DateTime? date;
  final VoidCallback onRefresh;

  const CalendarListTile({
    super.key,
    required this.eventItem,
    this.date,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final timeFormatter = DateFormat.Hm(locale);
    final model = eventItem.main;
    String start = '', end = '';
    if (model is Appointment) {
      start = model.start?.onlyDate() == date && model.start != null
          ? timeFormatter.format(model.start!)
          : '';
      end = model.end?.onlyDate() == date && model.end != null
          ? timeFormatter.format(model.end!)
          : '';
    } else if (model is Moment) {
      start = model.time?.onlyDate() == date && model.time != null
          ? timeFormatter.format(model.time!)
          : '';
    }
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
    final main = eventItem.main;
    return ListTile(
      title: Text(model.name),
      subtitle: Text(range),
      leading: Icon(model.status.getIcon(main is Appointment),
          color: model.status.getColor()),
      onTap: () {
        if (main is Appointment) {
          showDialog(
              context: context,
              builder: (context) => AppointmentDialog(
                    appointment: main,
                    event: eventItem.subSourced,
                  )).then((_) => onRefresh());
        }
        if (main is Moment) {
          showDialog(
              context: context,
              builder: (context) => MomentDialog(
                    moment: main,
                    event: eventItem.subSourced,
                  )).then((_) => onRefresh());
        }
      },
      trailing: FutureBuilder<bool?>(
        future: Future.value(context
            .read<FlowCubit>()
            .getService(eventItem.source)
            .note
            ?.notesDone(eventItem.sub.id)),
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
