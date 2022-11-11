import 'package:flow/pages/groups/group.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  static const _pageSize = 10;
  late final FlowCubit _flowCubit;
  final PagingController<int, MapEntry<EventGroup, String>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
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
      selected: "groups",
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
              itemBuilder: (context, item, index) => Dismissible(
                key: ValueKey(item.key.id),
                onDismissed: (direction) async {
                  await _flowCubit
                      .getSource(item.value)
                      .eventGroup
                      .deleteGroup(item.key.id);
                  _pagingController.itemList!.remove(item);
                  _pagingController.refresh();
                },
                background: Container(
                  color: Colors.red,
                ),
                child: ListTile(
                  title: Text(item.key.name),
                  subtitle: Text(item.key.description),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
                context: context,
                builder: (context) => const EventGroupDialog())
            .then((value) => _pagingController.refresh()),
        label: Text(AppLocalizations.of(context)!.create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}
