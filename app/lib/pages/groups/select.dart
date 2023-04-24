import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/model.dart';
import 'package:shared/services/source.dart';

import '../../widgets/builder_delegate.dart';

class GroupSelectDialog extends StatefulWidget {
  final String? source;
  final SourcedModel<String>? selected;
  final String? ignore;

  const GroupSelectDialog({
    super.key,
    this.source,
    this.selected,
    this.ignore,
  });

  @override
  State<GroupSelectDialog> createState() => _GroupSelectDialogState();
}

class _GroupSelectDialogState extends State<GroupSelectDialog> {
  static const _pageSize = 20;
  final TextEditingController _controller = TextEditingController();
  final PagingController<int, SourcedModel<Group>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(_fetchPage);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final cubit = context.read<FlowCubit>();
      Map<String, SourceService> sources = widget.source == null
          ? cubit.getCurrentServicesMap()
          : {widget.source!: cubit.getService(widget.source!)};
      final groups = await Future.wait(sources.entries.map((source) async {
        return (await source.value.group?.getGroups(
              offset: pageKey * _pageSize,
              limit: _pageSize,
              search: _controller.text,
            ))
                ?.map((group) => SourcedModel(source.key, group))
                .where((element) =>
                    element.model.id != widget.ignore ||
                    source.key != widget.source)
                .toList() ??
            <SourcedModel<Group>>[];
      }));
      final allGroups = groups.expand((element) => element).toList();
      final isLast = groups.length < _pageSize;
      if (isLast) {
        _pagingController.appendLastPage(allGroups);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(allGroups, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).group),
      content: SizedBox(
        height: 400,
        width: 400,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).search,
                icon: const Icon(Icons.search_outlined),
              ),
              controller: _controller,
              onSubmitted: (_) {
                _pagingController.refresh();
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: PagedListView<int, SourcedModel<Group>>(
                pagingController: _pagingController,
                builderDelegate:
                    buildMaterialPagedDelegate<SourcedModel<Group>>(
                  _pagingController,
                  (context, item, index) => ListTile(
                    title: Text(item.model.name),
                    selected: widget.selected?.model == item.model.id &&
                        widget.selected?.source == item.source,
                    onTap: () {
                      Navigator.of(context).pop(item);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
      ],
    );
  }
}
