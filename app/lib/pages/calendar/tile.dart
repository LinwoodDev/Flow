import 'package:flow/helpers/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/event/item/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import 'item.dart';

class CalendarListTile extends StatelessWidget {
  final SourcedConnectedModel<CalendarItem, Event?> eventItem;
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
    final type = model.type;
    switch (type) {
      case CalendarItemType.appointment:
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
        break;
      case CalendarItemType.moment:
        range = model.start?.onlyDate() == date && model.start != null
            ? timeFormatter.format(model.start!)
            : '';
        break;
      case CalendarItemType.pending:
        break;
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
        child: PhosphorIcon(
          model.status.icon(main.type == CalendarItemType.appointment
              ? PhosphorIconsStyle.bold
              : PhosphorIconsStyle.light),
          color: model.status.getColor(),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => CalendarItemDialog(
                  item: main,
                  event: eventItem.sub,
                  source: eventItem.source,
                )).then((_) => onRefresh());
      },
      trailing: FutureBuilder<bool?>(
        future: Future.value(eventItem.sub == null
            ? null
            : service.calendarItemNote?.notesDone(eventItem.sub!.id!)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PhosphorIcon(
              snapshot.data!
                  ? PhosphorIconsLight.checkCircle
                  : PhosphorIconsLight.circle,
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
