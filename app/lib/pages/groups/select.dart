import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/model.dart';
import 'package:shared/services/source.dart';

import '../../widgets/builder_delegate.dart';
import 'group.dart';

class GroupSelectTile extends StatefulWidget {
  final String source;
  final Multihash? value;
  final ValueChanged<Multihash?> onChanged;

  const GroupSelectTile({
    super.key,
    required this.source,
    this.value,
    required this.onChanged,
  });

  @override
  State<GroupSelectTile> createState() => _GroupSelectTileState();
}

class _GroupSelectTileState extends State<GroupSelectTile> {
  Multihash? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _onChanged(Multihash? value) {
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Group?>(
        future: Future.value(_value == null
            ? null
            : context
                .read<FlowCubit>()
                .getService(widget.source)
                .group
                ?.getGroup(_value!)),
        builder: (context, snapshot) {
          final group = snapshot.data;
          return ListTile(
            title: Text(AppLocalizations.of(context).group),
            subtitle: Text(group?.name ?? AppLocalizations.of(context).notSet),
            leading: PhosphorIcon(PhosphorIcons.users(group == null
                ? PhosphorIconsStyle.light
                : PhosphorIconsStyle.fill)),
            onTap: () async {
              SourcedModel<Group>? model;
              if (group != null) {
                Navigator.of(context).pop();
                model = await showDialog<SourcedModel<Group>>(
                  context: context,
                  builder: (context) => GroupDialog(
                    group: group,
                    source: widget.source,
                  ),
                );
              } else {
                model = await showDialog<SourcedModel<Group>>(
                  context: context,
                  builder: (context) => GroupSelectDialog(
                    source: widget.source,
                  ),
                );
              }
              if (model != null) {
                _onChanged(model.model.id);
              }
            },
            trailing: _value == null
                ? IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                    onPressed: () async {
                      final model = await showDialog<SourcedModel<Group>>(
                        context: context,
                        builder: (context) => GroupDialog(
                          source: widget.source,
                          create: true,
                        ),
                      );
                      if (model != null) {
                        _onChanged(model.model.id);
                      }
                    },
                  )
                : IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.x),
                    onPressed: () {
                      _onChanged(null);
                    },
                  ),
          );
        });
  }
}

class GroupSelectDialog extends StatefulWidget {
  final String? source;
  final SourcedModel<Multihash>? selected;
  final Multihash? ignore;

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
                icon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
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
