import 'package:flow/blocs/sourced_paging.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/user/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/markdown_field.dart';
import '../calendar/filter.dart';
import 'user.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.source,
    required this.user,
    required this.flowCubit,
    required this.bloc,
  });

  final FlowCubit flowCubit;
  final User user;
  final String source;
  final SourcedPagingBloc<User> bloc;

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
          _deleteUser,
        ),
      ]
          .map((e) => MenuItemButton(
                onPressed: () => e.$3(context),
                leadingIcon: PhosphorIcon(e.$1),
                child: Text(e.$2),
              ))
          .toList(),
      builder: (context, button, controller) => ListTile(
        title: Text(user.name),
        subtitle: MarkdownText(user.description),
        onTap: () => _editUser(context),
        trailing: button,
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
              bloc.remove(SourcedModel(
                source,
                user,
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
    ).then((value) => bloc.refresh());
  }
}
