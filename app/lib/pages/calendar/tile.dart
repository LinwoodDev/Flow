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
  final SourcedConnectedModel<EventItem, Event?> eventItem;
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
    final cubit = context.read<FlowCubit>();
    final service = cubit.getService(eventItem.source);
    final locale = Localizations.localeOf(context).languageCode;
    final timeFormatter = DateFormat.Hm(locale);
    final model = eventItem.main;
    final eventName = eventItem.sub?.name;
    final name = model.name.isEmpty ? eventName : model.name;
    String range = '';
    if (model is Appointment) {
      final start = model.start?.onlyDate() == date && model.start != null
          ? timeFormatter.format(model.start!)
          : '';
      final end = model.end?.onlyDate() == date && model.end != null
          ? timeFormatter.format(model.end!)
          : '';
      if (start == '' && end == '') {
        range = '';
      } else if (start == '') {
        range = ' - $end';
      } else if (end == '') {
        range = '$start -';
      } else {
        range = '$start - $end';
      }
    } else if (model is Moment) {
      range = model.time?.onlyDate() == date && model.time != null
          ? timeFormatter.format(model.time!)
          : '';
    }
    final main = eventItem.main;
    return ListTile(
      title: Text(name ?? ''),
      subtitle: Wrap(
        spacing: 16,
        children: [
          if (range.isNotEmpty) ...[
            Text(range),
          ],
          if (eventName != name && eventName != null) Text(eventName),
        ],
      ),
      leading: Tooltip(
        message: model.status.getLocalizedName(context),
        child: Icon(
          model.status.getIcon(main is Appointment),
          color: model.status.getColor(),
        ),
      ),
      onTap: () {
        if (main is Appointment) {
          showDialog(
              context: context,
              builder: (context) => AppointmentDialog(
                    appointment: main,
                    event: eventItem.sub,
                    source: eventItem.source,
                  )).then((_) => onRefresh());
        }
        if (main is Moment) {
          showDialog(
              context: context,
              builder: (context) => MomentDialog(
                    moment: main,
                    event: eventItem.sub,
                    source: eventItem.source,
                  )).then((_) => onRefresh());
        }
      },
      trailing: FutureBuilder<bool?>(
        future: Future.value(eventItem.sub == null
            ? null
            : (main is Appointment
                    ? service.appointmentNote
                    : service.momentNote)
                ?.notesDone(eventItem.sub!.id)),
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
