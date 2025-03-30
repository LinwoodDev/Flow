import 'package:flow_api/services/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/user/model.dart';
import 'package:flow_api/models/user/service.dart';

import '../../cubits/flow.dart';
import '../../widgets/builder_delegate.dart';
import 'user.dart';

class UsersView<T extends DescriptiveModel> extends StatefulWidget {
  final T model;
  final String source;
  final ModelConnector<User, T> connector;

  const UsersView(
      {super.key,
      required this.source,
      required this.connector,
      required this.model});

  UsersView.reversed(
      {super.key,
      required this.source,
      required ModelConnector<T, User> connector,
      required this.model})
      : connector = ReversedModelConnector(connector);

  @override
  State<UsersView<T>> createState() => _UsersViewState();
}

class _UsersViewState<T extends DescriptiveModel> extends State<UsersView<T>> {
  static const _pageSize = 20;

  late final UserService? _userService;

  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    final service = context.read<FlowCubit>().getService(widget.source);
    _userService = service.user;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await widget.connector.getItems(widget.model.id!,
          offset: pageKey * _pageSize, limit: _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      Stack(
        children: [
          Column(
            children: [
              Flexible(
                child: PagedListView<int, User>(
                  pagingController: _pagingController,
                  builderDelegate: buildMaterialPagedDelegate<User>(
                    _pagingController,
                    (context, item, index) {
                      return Dismissible(
                        key: ValueKey(item.id),
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          _userService?.deleteUser(item.id!);
                          _pagingController.itemList!.remove(item);
                        },
                        child: ListTile(
                          title: Text(item.name),
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => UserDialog(
                                source: widget.source,
                                user: item,
                              ),
                            );
                            _pagingController.refresh();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                label: Text(AppLocalizations.of(context).link),
                icon: const PhosphorIcon(PhosphorIconsLight.link),
                onPressed: () async {
                  final user = await showDialog<SourcedModel<User>>(
                    context: context,
                    builder: (context) => UserDialog(
                      source: widget.source,
                    ),
                  );
                  if (user != null) {
                    await widget.connector
                        .connect(widget.model.id!, user.model.id!);
                  }
                  _pagingController.refresh();
                },
              ),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
