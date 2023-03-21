import 'package:flow/pages/groups/group.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/model.dart';

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
  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).groups,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () =>
              showSearch(context: context, delegate: _GroupsSearchDelegate()),
        ),
      ],
      body: const GroupsBodyView(),
    );
  }
}

class _GroupsSearchDelegate extends SearchDelegate {
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
    return GroupsBodyView(
      search: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class GroupsBodyView extends StatefulWidget {
  final String search;

  const GroupsBodyView({
    super.key,
    this.search = '',
  });

  @override
  State<GroupsBodyView> createState() => _GroupsBodyViewState();
}

class _GroupsBodyViewState extends State<GroupsBodyView> {
  static const _pageSize = 20;
  late final FlowCubit _flowCubit;
  final PagingController<int, SourcedModel<Group>> _controller =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _controller.addPageRequestListener(_fetchPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant GroupsBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      _controller.refresh();
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final sources = _flowCubit.getCurrentServicesMap().entries;
      final groups = <SourcedModel<Group>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.group?.getGroups(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          search: widget.search,
        );
        if (fetched == null) continue;
        groups.addAll(fetched.map((note) => SourcedModel(source.key, note)));
        if (fetched.length < _pageSize) {
          isLast = true;
        }
      }
      if (isLast) {
        _controller.appendLastPage(groups);
      } else {
        final nextPageKey = pageKey + 1;
        _controller.appendPage(groups, nextPageKey);
      }
    } catch (error) {
      _controller.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedListView(
        pagingController: _controller,
        builderDelegate: buildMaterialPagedDelegate<SourcedModel<Group>>(
          _controller,
          (ctx, item, index) => Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Dismissible(
                key: ValueKey('${item.model.id}@${item.source}'),
                onDismissed: (direction) async {
                  await _flowCubit
                      .getSource(item.source)
                      .group
                      ?.deleteGroup(item.model.id);
                  _controller.itemList!.remove(item);
                },
                background: Container(
                  color: Colors.red,
                ),
                child: GroupTile(
                  flowCubit: _flowCubit,
                  pagingController: _controller,
                  source: item.source,
                  group: item.model,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog<Group>(
                context: context, builder: (context) => const GroupDialog())
            .then((_) => _controller.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}
