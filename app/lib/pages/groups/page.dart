import 'package:flow/pages/groups/group.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';

import '../../cubits/flow.dart';
import 'tile.dart';

class EventGroupsPage extends StatefulWidget {
  const EventGroupsPage({
    super.key,
  });

  @override
  _EventGroupsPageState createState() => _EventGroupsPageState();
}

class _EventGroupsPageState extends State<EventGroupsPage> {
  final PagingController<int, MapEntry<EventGroup, String>> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context)!.groups,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () => showSearch(
              context: context, delegate: _EventGroupsSearchDelegate()),
        ),
      ],
      body: EventGroupsBodyView(pagingController: _pagingController),
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

class _EventGroupsSearchDelegate extends SearchDelegate {
  final PagingController<int, MapEntry<EventGroup, String>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _pagingController.refresh();
    return EventGroupsBodyView(
      pagingController: _pagingController,
      search: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class EventGroupsBodyView extends StatefulWidget {
  final PagingController<int, MapEntry<EventGroup, String>> pagingController;
  final String search;

  const EventGroupsBodyView({
    super.key,
    required this.pagingController,
    this.search = '',
  });

  @override
  State<EventGroupsBodyView> createState() => _EventGroupsBodyViewState();
}

class _EventGroupsBodyViewState extends State<EventGroupsBodyView> {
  static const _pageSize = 20;
  late final FlowCubit _flowCubit;

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    widget.pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  @override
  void dispose() {
    widget.pagingController.removePageRequestListener(_fetchPage);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant EventGroupsBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      widget.pagingController.refresh();
    }
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
          search: widget.search,
        );
        todos.addAll(fetched.map((todo) => MapEntry(todo, source.key)));
        if (fetched.length < _pageSize) {
          isLast = true;
        }
      }
      if (isLast) {
        widget.pagingController.appendLastPage(todos);
      } else {
        final nextPageKey = pageKey + 1;
        widget.pagingController.appendPage(todos, nextPageKey);
      }
    } catch (error) {
      widget.pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView(
      pagingController: widget.pagingController,
      builderDelegate: PagedChildBuilderDelegate<MapEntry<EventGroup, String>>(
        itemBuilder: (ctx, item, index) => Align(
          key: ValueKey('${item.key.id}@${item.value}'),
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Dismissible(
              key: ValueKey(item.key.id),
              onDismissed: (direction) async {
                await _flowCubit
                    .getSource(item.value)
                    .eventGroup
                    .deleteGroup(item.key.id);
                widget.pagingController.itemList!.remove(item);
              },
              background: Container(
                color: Colors.red,
              ),
              child: EventGroupTile(
                flowCubit: _flowCubit,
                pagingController: widget.pagingController,
                source: item.value,
                eventGroup: item.key,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
