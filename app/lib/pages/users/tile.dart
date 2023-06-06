import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/user/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/markdown_field.dart';
import '../calendar/filter.dart';
import 'user.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.source,
    required this.user,
    required this.flowCubit,
    required this.pagingController,
  }) : super(key: key);

  final FlowCubit flowCubit;
  final User user;
  final String source;
  final SourcedPagingController<User> pagingController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: MarkdownText(user.description),
      onTap: () => _editUser(context),
      trailing: MenuAnchor(
        builder: defaultMenuButton(),
        menuChildren: [
          (
            PhosphorIconsLight.calendar,
            AppLocalizations.of(context).events,
            _openEvents,
          ),
          (
            PhosphorIconsLight.trash,
            AppLocalizations.of(context).delete,
            _deleteUser,
          ),
        ]
            .map((e) => MenuItemButton(
                  onPressed: () => e.$3(context),
                  leadingIcon: PhosphorIcon(e.$1),
                  child: Text(e.$2),
                ))
            .toList(),
      ),
    );
  }

  void _deleteUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteUser(user.name)),
        content:
            Text(AppLocalizations.of(context).deleteUserDescription(user.name)),
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
              await flowCubit.getService(source).user?.deleteUser(user.id!);
              pagingController.itemList!.remove(SourcedModel(
                source,
                user,
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
        source: source,
      ),
    );
  }

  void _editUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => UserDialog(
        user: user,
        source: source,
      ),
    ).then((value) => pagingController.refresh());
  }
}
