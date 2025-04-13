import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/pages/users/user.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/user/model.dart';

import '../../cubits/flow.dart';
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
          icon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
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
  late final SourcedPagingBloc<User> _bloc;
  late UserFilter _filter;

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _bloc = SourcedPagingBloc<User>.item(
        cubit: _flowCubit,
        fetch: (source, service, offset, limit) async =>
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
    _bloc.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant UsersBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      _bloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserFilterView(
              initialFilter: _filter,
              onChanged: (filter) {
                setState(() {
                  _filter = filter;
                });
                _bloc.refresh();
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: PagedListView.item(
                bloc: _bloc,
                itemBuilder: (ctx, item, index) => Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Dismissible(
                      key: ValueKey('${item.model.id}@${item.source}'),
                      onDismissed: (direction) async {
                        await _flowCubit
                            .getService(item.source)
                            .user
                            ?.deleteUser(item.model.id!);
                        _bloc.remove(item);
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: UserTile(
                        flowCubit: _flowCubit,
                        bloc: _bloc,
                        source: item.source,
                        user: item.model,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
                context: context, builder: (context) => const UserDialog())
            .then((_) => _bloc.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }
}
