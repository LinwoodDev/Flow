import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/label/model.dart';
import 'package:shared/services/source.dart';

import '../../widgets/builder_delegate.dart';
import 'label.dart';

class LabelSelectTile extends StatefulWidget {
  final String source;
  final Multihash? value;
  final ValueChanged<Multihash?> onChanged;

  const LabelSelectTile({
    super.key,
    required this.source,
    this.value,
    required this.onChanged,
  });

  @override
  State<LabelSelectTile> createState() => _LabelSelectTileState();
}

class _LabelSelectTileState extends State<LabelSelectTile> {
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
    return FutureBuilder<Label?>(
        future: Future.value(_value == null
            ? null
            : context
                .read<FlowCubit>()
                .getService(widget.source)
                .label
                ?.getLabel(_value!)),
        builder: (context, snapshot) {
          final label = snapshot.data;
          return ListTile(
            title: Text(AppLocalizations.of(context).label),
            subtitle: Text(label?.name ?? AppLocalizations.of(context).notSet),
            leading: PhosphorIcon(PhosphorIcons.calendar(label == null
                ? PhosphorIconsStyle.light
                : PhosphorIconsStyle.fill)),
            onTap: () async {
              if (label != null) {
                Navigator.of(context).pop();
                final model = await showDialog<SourcedModel<Label>>(
                  context: context,
                  builder: (context) => LabelDialog(
                    label: label,
                    source: widget.source,
                  ),
                );
                if (model != null) {
                  _onChanged(model.model.id);
                }
              } else {
                final model = await showDialog<SourcedModel<Label>>(
                  context: context,
                  builder: (context) => LabelSelectDialog(
                    source: widget.source,
                  ),
                );
                if (model != null) {
                  _onChanged(model.model.id);
                }
              }
            },
            trailing: _value == null
                ? IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                    onPressed: () async {
                      final label = await showDialog<SourcedModel<Label>>(
                        context: context,
                        builder: (context) => LabelDialog(
                          source: widget.source,
                          create: true,
                        ),
                      );
                      _onChanged(label?.model.id);
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

class LabelSelectDialog extends StatefulWidget {
  final String? source;
  final SourcedModel<Multihash>? selected;

  const LabelSelectDialog({
    super.key,
    this.source,
    this.selected,
  });

  @override
  State<LabelSelectDialog> createState() => _LabelSelectDialogState();
}

class _LabelSelectDialogState extends State<LabelSelectDialog> {
  static const _pageSize = 20;
  final TextEditingController _controller = TextEditingController();
  final PagingController<int, SourcedModel<Label>> _pagingController =
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
      final labels = await Future.wait(sources.entries.map((source) async {
        final labels = await source.value.label?.getLabels(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          search: _controller.text,
        );
        return (labels ?? <Label>[])
            .map((label) => SourcedModel(source.key, label))
            .toList();
      }));
      final allLabels = labels.expand((element) => element).toList();
      final isLast = labels.length < _pageSize;
      if (isLast) {
        _pagingController.appendLastPage(allLabels);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(allLabels, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).label),
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
              child: PagedListView<int, SourcedModel<Label>>(
                pagingController: _pagingController,
                builderDelegate:
                    buildMaterialPagedDelegate<SourcedModel<Label>>(
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
