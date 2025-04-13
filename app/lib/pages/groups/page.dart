import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/pages/groups/group.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/group/model.dart';

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
          icon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
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
        icon: const PhosphorIcon(PhosphorIconsLight.x),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const PhosphorIcon(PhosphorIconsLight.arrowLeft),
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
  late final FlowCubit _flowCubit;
  late final SourcedPagingBloc<Group> _bloc;

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _bloc = SourcedPagingBloc<Group>.item(
        cubit: _flowCubit,
        fetch: (source, service, offset, limit) async =>
            service.group?.getGroups(offset: offset, limit: limit));
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant GroupsBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      _bloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedListView.item(
        bloc: _bloc,
        itemBuilder: (ctx, item, index) => Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Dismissible(
              key: ValueKey('${item.model.id}@${item.source}'),
              onDismissed: (direction) async {
                await _flowCubit
                    .getService(item.source)
                    .group
                    ?.deleteGroup(item.model.id!);
                _bloc.remove(item);
              },
              background: Container(
                color: Colors.red,
              ),
              child: GroupTile(
                flowCubit: _flowCubit,
                bloc: _bloc,
                source: item.source,
                group: item.model,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
                context: context, builder: (context) => const GroupDialog())
            .then((_) => _bloc.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }
}
