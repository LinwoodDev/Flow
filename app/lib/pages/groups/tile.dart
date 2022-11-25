import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cubits/flow.dart';
import '../calendar/filter.dart';
import 'group.dart';

class EventGroupTile extends StatelessWidget {
  const EventGroupTile({
    Key? key,
    required this.source,
    required this.eventGroup,
    required this.flowCubit,
    required this.pagingController,
  }) : super(key: key);

  final FlowCubit flowCubit;
  final EventGroup eventGroup;
  final String source;
  final PagingController<int, MapEntry<EventGroup, String>> pagingController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(eventGroup.name),
      subtitle: Text(eventGroup.description),
      onTap: () => _editGroup(context),
      trailing: PopupMenuButton<Function>(
        itemBuilder: (ctx) => <dynamic>[
          [
            Icons.calendar_month_outlined,
            AppLocalizations.of(context)!.events,
            _openEvents,
          ],
          [
            Icons.delete_outline,
            AppLocalizations.of(context)!.delete,
            _deleteGroup,
          ],
        ]
            .map((e) => PopupMenuItem<Function>(
                  value: e[2],
                  child: Row(
                    children: [
                      Icon(e[0]),
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

  void _deleteGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteGroup(eventGroup.name)),
        content: Text(AppLocalizations.of(context)!
            .deleteGroupDescription(eventGroup.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context)!.cancel,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await flowCubit
                  .getSource(source)
                  .eventGroup
                  .deleteGroup(eventGroup.id);
              pagingController.itemList!.remove(MapEntry(
                eventGroup,
                source,
              ));
              pagingController.refresh();
            },
            child: Text(
              AppLocalizations.of(context)!.delete,
            ),
          ),
        ],
      ),
    );
  }

  void _openEvents(BuildContext context) {
    GoRouter.of(context).go(
      "/calendar",
      extra: CalendarFilter(
        group: eventGroup.id,
        source: source,
      ),
    );
  }

  void _editGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => GroupDialog(
        eventGroup: eventGroup,
        source: source,
      ),
    ).then((value) => pagingController.refresh());
  }
}
