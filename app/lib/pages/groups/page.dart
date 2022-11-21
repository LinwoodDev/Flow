import 'package:flow/pages/calendar/filter.dart';
import 'package:flow/pages/groups/group.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';

import '../../cubits/flow.dart';

class EventGroupsPage extends StatefulWidget {
  const EventGroupsPage({
    super.key,
  });

  @override
  _EventGroupsPageState createState() => _EventGroupsPageState();
}

class _EventGroupsPageState extends State<EventGroupsPage> {
  static const _pageSize = 20;
  late final FlowCubit _flowCubit;
  final PagingController<int, MapEntry<EventGroup, String>> _pagingController =
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
      final todos = <MapEntry<EventGroup, String>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.eventGroup.getGroups(
          offset: pageKey * _pageSize,
          limit: _pageSize,
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
      title: AppLocalizations.of(context)!.groups,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () async {},
        ),
      ],
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: PagedListView(
            pagingController: _pagingController,
            builderDelegate:
                PagedChildBuilderDelegate<MapEntry<EventGroup, String>>(
              itemBuilder: (ctx, item, index) => Dismissible(
                key: ValueKey(item.key.id),
                onDismissed: (direction) async {
                  await _flowCubit
                      .getSource(item.value)
                      .eventGroup
                      .deleteGroup(item.key.id);
                  _pagingController.itemList!.remove(item);
                },
                background: Container(
                  color: Colors.red,
                ),
                child: EventGroupTile(
                  flowCubit: _flowCubit,
                  pagingController: _pagingController,
                  source: item.value,
                  eventGroup: item.key,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
                context: context, builder: (context) => const GroupDialog())
            .then((value) => _pagingController.refresh()),
        label: Text(AppLocalizations.of(context)!.create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}

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
