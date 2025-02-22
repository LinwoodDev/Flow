import 'package:flow_api/services/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/models/group/service.dart';

import '../../cubits/flow.dart';
import '../../widgets/builder_delegate.dart';
import 'group.dart';

class GroupsView<T extends DescriptiveModel> extends StatefulWidget {
  final T model;
  final String source;
  final ModelConnector<T, Group> connector;

  const GroupsView(
      {super.key,
      required this.source,
      required this.connector,
      required this.model});

  @override
  State<GroupsView<T>> createState() => _GroupsViewState();
}

class _GroupsViewState<T extends DescriptiveModel>
    extends State<GroupsView<T>> {
  static const _pageSize = 20;

  late final GroupService? _groupService;

  final PagingController<int, Group> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    final service = context.read<FlowCubit>().getService(widget.source);
    _groupService = service.group;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await widget.connector.getConnected(widget.model.id!,
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
                child: PagedListView<int, Group>(
                  pagingController: _pagingController,
                  builderDelegate: buildMaterialPagedDelegate<Group>(
                    _pagingController,
                    (context, item, index) {
                      return Dismissible(
                        key: ValueKey(item.id),
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          _groupService?.deleteGroup(item.id!);
                          _pagingController.itemList!.remove(item);
                        },
                        child: ListTile(
                          title: Text(item.name),
                          onTap: () async {
                            await showDialog<Group>(
                              context: context,
                              builder: (context) => GroupDialog(
                                source: widget.source,
                                group: item,
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
                label: Text(AppLocalizations.of(context).create),
                icon: const PhosphorIcon(PhosphorIconsLight.plus),
                onPressed: () async {
                  final group = await showDialog<Group>(
                    context: context,
                    builder: (context) => GroupDialog(
                      source: widget.source,
                    ),
                  );
                  if (group != null) {
                    await widget.connector.connect(group.id!, widget.model.id!);
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
