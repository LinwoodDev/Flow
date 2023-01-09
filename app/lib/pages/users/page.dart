import 'package:flow/pages/calendar/filter.dart';
import 'package:flow/pages/users/filter.dart';
import 'package:flow/pages/users/user.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/user/model.dart';

import '../../cubits/flow.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({
    super.key,
  });

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  static const _pageSize = 20;
  late final FlowCubit _flowCubit;
  UserFilter _filter = const UserFilter();
  final PagingController<int, MapEntry<User, String>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final sources = _flowCubit.getCurrentServicesMap().entries;
      final todos = <MapEntry<User, String>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.user.getUsers(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          groupId: source.key == _filter.source ? _filter.group : null,
        );
        todos.addAll(fetched.map((todo) => MapEntry(todo, source.key)));
        if (fetched.length < _pageSize) {
          isLast = true;
        }
      }
      if (isLast) {
        _pagingController.appendLastPage(todos);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(todos, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).users,
      body: Column(
        children: [
          UserFilterView(
            initialFilter: _filter,
            onChanged: (filter) {
              setState(() {
                _filter = filter;
              });
              _pagingController.refresh();
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: PagedListView(
                  pagingController: _pagingController,
                  builderDelegate:
                      PagedChildBuilderDelegate<MapEntry<User, String>>(
                    itemBuilder: (ctx, item, index) => Dismissible(
                      key: ValueKey(item.key.id),
                      onDismissed: (direction) async {
                        await _flowCubit
                            .getSource(item.value)
                            .user
                            .deleteUser(item.key.id);
                        _pagingController.itemList!.remove(item);
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: UserTile(
                        flowCubit: _flowCubit,
                        pagingController: _pagingController,
                        source: item.value,
                        user: item.key,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
                context: context, builder: (context) => const UserDialog())
            .then((value) => _pagingController.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}

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
  final PagingController<int, MapEntry<User, String>> pagingController;

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
              await flowCubit.getSource(source).user.deleteUser(user.id);
              pagingController.itemList!.remove(MapEntry(
                user,
                source,
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
