import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/models/model.dart';

import '../../cubits/flow.dart';
import '../../helpers/sourced_paging_controller.dart';
import '../../widgets/markdown_field.dart';
import '../calendar/filter.dart';
import '../users/filter.dart';
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
  final SourcedPagingController<Group> pagingController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(group.name),
      subtitle: MarkdownText(group.description),
      onTap: () => _editGroup(context),
      trailing: MenuAnchor(
        builder: defaultMenuButton(),
        menuChildren: [
          (
            PhosphorIconsLight.calendar,
            AppLocalizations.of(context).events,
            _openEvents,
          ),
          (
            PhosphorIconsLight.users,
            AppLocalizations.of(context).users,
            _openUsers,
          ),
          (
            PhosphorIconsLight.trash,
            AppLocalizations.of(context).delete,
            _deleteGroup,
          ),
        ]
            .map((e) => MenuItemButton(
                  leadingIcon: PhosphorIcon(e.$1),
                  child: Text(e.$2),
                  onPressed: () => e.$3(context),
                ))
            .toList(),
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
              await flowCubit.getService(source).group?.deleteGroup(group.id!);
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

  void _openUsers(BuildContext context) {
    GoRouter.of(context).go(
      "/users",
      extra: UserFilter(
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
