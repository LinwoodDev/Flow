import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../calendar/filter.dart';
import 'group.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({
    Key? key,
    required this.source,
    required this.group,
    required this.flowCubit,
    required this.pagingController,
  }) : super(key: key);

  final FlowCubit flowCubit;
  final Group group;
  final String source;
  final PagingController<int, SourcedModel<Group>> pagingController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(group.name),
      subtitle: Text(group.description),
      onTap: () => _editGroup(context),
      trailing: PopupMenuButton<Function>(
        itemBuilder: (ctx) => <dynamic>[
          [
            Icons.calendar_month_outlined,
            AppLocalizations.of(context).events,
            _openEvents,
          ],
          [
            Icons.people_outlined,
            AppLocalizations.of(context).users,
            _openEvents,
          ],
          [
            Icons.delete_outline,
            AppLocalizations.of(context).delete,
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
        title: Text(AppLocalizations.of(context).deleteGroup(group.name)),
        content: Text(
            AppLocalizations.of(context).deleteGroupDescription(group.name)),
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
              await flowCubit.getService(source).group?.deleteGroup(group.id);
              pagingController.itemList!.remove(SourcedModel(
                source,
                group,
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

  void _openEvents(BuildContext context) {
    GoRouter.of(context).go(
      "/calendar",
      extra: CalendarFilter(
        group: group.id,
        source: source,
      ),
    );
  }

  void _editGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => GroupDialog(
        group: group,
        source: source,
      ),
    ).then((value) => pagingController.refresh());
  }
}
