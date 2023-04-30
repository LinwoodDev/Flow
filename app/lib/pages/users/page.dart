import 'package:flow/pages/users/user.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/user/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../../helpers/sourced_paging_controller.dart';
import 'filter.dart';
import 'tile.dart';

class UsersPage extends StatefulWidget {
  final UserFilter filter;
  const UsersPage({
    super.key,
    this.filter = const UserFilter(),
  });

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).users,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () => showSearch(
            context: context,
            delegate: _UsersSearchDelegate(
              widget.filter,
            ),
          ),
        ),
      ],
      body: UsersBodyView(
        filter: widget.filter,
      ),
    );
  }
}

class _UsersSearchDelegate extends SearchDelegate {
  final UserFilter filter;

  _UsersSearchDelegate(this.filter);

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
    return UsersBodyView(
      search: query,
      filter: filter,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class UsersBodyView extends StatefulWidget {
  final String search;
  final UserFilter filter;

  const UsersBodyView({
    super.key,
    this.search = '',
    this.filter = const UserFilter(),
  });

  @override
  State<UsersBodyView> createState() => _UsersBodyViewState();
}

class _UsersBodyViewState extends State<UsersBodyView> {
  late final FlowCubit _flowCubit;
  late final SourcedPagingController<User> _controller;
  late UserFilter _filter;

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _controller = SourcedPagingController(_flowCubit);
    _controller.addFetchListener((source, service, offset, limit) async =>
        _filter.source != null && _filter.source != source
            ? null
            : service.user?.getUsers(
                offset: offset,
                limit: limit,
                groupId: _filter.group,
                search: widget.search));
    _filter = widget.filter;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant UsersBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      _controller.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserFilterView(
            initialFilter: _filter,
            onChanged: (filter) {
              setState(() {
                _filter = filter;
              });
              _controller.refresh();
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: PagedListView(
              pagingController: _controller,
              builderDelegate: buildMaterialPagedDelegate<SourcedModel<User>>(
                _controller,
                (ctx, item, index) => Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Dismissible(
                      key: ValueKey('${item.model.id}@${item.source}'),
                      onDismissed: (direction) async {
                        await _flowCubit
                            .getService(item.source)
                            .user
                            ?.deleteUser(item.model.id!);
                        _controller.itemList!.remove(item);
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: UserTile(
                        flowCubit: _flowCubit,
                        pagingController: _controller,
                        source: item.source,
                        user: item.model,
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
            .then((_) => _controller.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}
