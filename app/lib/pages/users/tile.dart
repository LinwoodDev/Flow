import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/user/model.dart';

import '../../cubits/flow.dart';
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
      subtitle: Text(user.description),
      onTap: () => _editUser(context),
      trailing: PopupMenuButton<Function>(
        itemBuilder: (ctx) => <dynamic>[
          [
            Icons.calendar_month_outlined,
            AppLocalizations.of(context).events,
            _openEvents,
          ],
          [
            Icons.delete_outline,
            AppLocalizations.of(context).delete,
            _deleteUser,
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
