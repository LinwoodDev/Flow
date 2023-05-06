import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../../helpers/sourced_paging_controller.dart';
import '../../widgets/builder_delegate.dart';
import '../../widgets/markdown_field.dart';
import '../calendar/filter.dart';
import 'event.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.source,
    required this.event,
    required this.flowCubit,
    required this.pagingController,
  });

  final FlowCubit flowCubit;
  final Event event;
  final String source;
  final SourcedPagingController<Event> pagingController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.name),
      subtitle: MarkdownText(event.description),
      onTap: () => _editEvent(context),
      trailing: PopupMenuButton<Function>(
        itemBuilder: (ctx) => <dynamic>[
          [
            PhosphorIconsLight.calendar,
            AppLocalizations.of(context).events,
            _openEvents,
          ],
          [
            PhosphorIconsLight.trash,
            AppLocalizations.of(context).delete,
            _deleteEvent,
          ],
        ]
            .map((e) => PopupMenuItem<Function>(
                  value: e[2],
                  child: Row(
                    children: [
                      PhosphorIcon(e[0]),
                      const SizedBox(width: 8),
                      Text(e[1]),
                    ],
                  ),
                ))
            .toList(),
        onSelected: (value) => value(context),
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
              pagingController.itemList!.remove(SourcedModel(
                source,
                event,
              ));
              pagingController.refresh();
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
    ).then((value) => pagingController.refresh());
  }
}

Future<SourcedModel<Event>?> showEventModalBottomSheet(
    {required BuildContext context, Event? event, DateTime? time}) async {
  SourcedModel<Event>? event;
  final cubit = context.read<FlowCubit>();
  final pagingController = SourcedPagingController<Event>(cubit);
  pagingController.addFetchListener((source, service, offset, limit) async =>
      service.event?.getEvents(offset: offset, limit: limit));
  final shouldCreate = await showLeapBottomSheet<bool>(
      context: context,
      title: AppLocalizations.of(context).events,
      actionsBuilder: (ctx) => [
            TextButton.icon(
              icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
              label: Text(AppLocalizations.of(context).create),
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
            ),
          ],
      childrenBuilder: (ctx) => [
            PagedListView(
                shrinkWrap: true,
                pagingController: pagingController,
                builderDelegate:
                    buildMaterialPagedDelegate<SourcedModel<Event>>(
                  pagingController,
                  (ctx, item, index) {
                    return ListTile(
                      title: Text(item.model.name),
                      leading: const PhosphorIcon(PhosphorIconsLight.calendar),
                      onTap: () {
                        event = item;
                        Navigator.of(ctx).pop();
                      },
                    );
                  },
                )),
          ]);
  pagingController.dispose();
  if (shouldCreate == true && context.mounted) {
    event = await showDialog(
      context: context,
      builder: (ctx) => EventDialog(
        event: event?.model,
        source: event?.source,
      ),
    );
  }
  return event;
}
