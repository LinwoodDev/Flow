import 'package:flow/blocs/sourced_paging.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/markdown_field.dart';
import '../calendar/filter.dart';
import 'event.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.source,
    required this.event,
    required this.flowCubit,
    required this.bloc,
  });

  final FlowCubit flowCubit;
  final Event event;
  final String source;
  final SourcedPagingBloc<Event> bloc;

  @override
  Widget build(BuildContext context) {
    return ContextRegion(
      menuChildren: [
        (
          PhosphorIconsLight.calendar,
          AppLocalizations.of(context).events,
          _openEvents,
        ),
        (
          PhosphorIconsLight.trash,
          AppLocalizations.of(context).delete,
          _deleteEvent,
        ),
      ]
          .map((e) => MenuItemButton(
                leadingIcon: PhosphorIcon(e.$1),
                onPressed: () => e.$3(context),
                child: Text(e.$2),
              ))
          .toList(),
      builder: (context, button, controller) => ListTile(
        title: Text(event.name),
        subtitle: MarkdownText(event.description),
        onTap: () => _editEvent(context),
        trailing: button,
      ),
    );
  }

  void _openEvents(BuildContext context) {
    GoRouter.of(context).go(
      "/calendar",
      extra: CalendarFilter(
        event: event.id,
        source: source,
      ),
    );
  }

  void _deleteEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteEvent(event.name)),
        content: Text(
            AppLocalizations.of(context).deleteEventDescription(event.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context).cancel,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await flowCubit.getService(source).event?.deleteEvent(event.id!);
              bloc.remove(SourcedModel(
                source,
                event,
              ));
              bloc.refresh();
            },
            child: Text(
              AppLocalizations.of(context).delete,
            ),
          ),
        ],
      ),
    );
  }

  void _editEvent(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EventDialog(
        event: event,
        source: source,
      ),
    ).then((value) => bloc.refresh());
  }
}
