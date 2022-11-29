import 'package:flow/pages/groups/group.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/group/model.dart';

import '../../cubits/flow.dart';
import 'tile.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({
    super.key,
  });

  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final PagingController<int, MapEntry<Group, String>> _pagingController =
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
          onPressed: () =>
              showSearch(context: context, delegate: _GroupsSearchDelegate()),
        ),
      ],
      body: GroupsBodyView(pagingController: _pagingController),
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

class _GroupsSearchDelegate extends SearchDelegate {
  final PagingController<int, MapEntry<Group, String>> _pagingController =
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
    return GroupsBodyView(
      pagingController: _pagingController,
      search: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class GroupsBodyView extends StatefulWidget {
  final PagingController<int, MapEntry<Group, String>> pagingController;
  final String search;

  const GroupsBodyView({
    super.key,
    required this.pagingController,
    this.search = '',
  });

  @override
  State<GroupsBodyView> createState() => _GroupsBodyViewState();
}

class _GroupsBodyViewState extends State<GroupsBodyView> {
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
  void didUpdateWidget(covariant GroupsBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      widget.pagingController.refresh();
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final sources = _flowCubit.getCurrentServicesMap().entries;
      final groups = <MapEntry<Group, String>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.group.getGroups(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          search: widget.search,
        );
        groups.addAll(fetched.map((todo) => MapEntry(todo, source.key)));
        if (fetched.length < _pageSize) {
          isLast = true;
        }
      }
      if (isLast) {
        widget.pagingController.appendLastPage(groups);
      } else {
        final nextPageKey = pageKey + 1;
        widget.pagingController.appendPage(groups, nextPageKey);
      }
    } catch (error) {
      widget.pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView(
      pagingController: widget.pagingController,
      builderDelegate: PagedChildBuilderDelegate<MapEntry<Group, String>>(
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
                    .group
                    .deleteGroup(item.key.id);
                widget.pagingController.itemList!.remove(item);
              },
              background: Container(
                color: Colors.red,
              ),
              child: GroupTile(
                flowCubit: _flowCubit,
                pagingController: widget.pagingController,
                source: item.value,
                group: item.key,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
