import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/services/source.dart';

import '../../widgets/builder_delegate.dart';

typedef ModelFetchCallback<T> = Future<T?> Function(
    String source, SourceService service, Multihash id);
typedef ModelWidgetBuilder<T> = Widget? Function(
    BuildContext context, SourcedModel<T?> model);
typedef ModelSelectBuilder<T> = Widget Function(
    BuildContext context, SourcedModel<T?> model);

class SelectTile<T extends NamedModel> extends StatefulWidget {
  final String source;
  final Multihash? value;
  final ValueChanged<Multihash?> onChanged;
  final ModelFetchCallback<T> onModelFetch;
  final ModelWidgetBuilder<T> leadingBuilder;
  final ModelSelectBuilder<T> selectBuilder;
  final ModelSelectBuilder<T> dialogBuilder;
  final String title;

  const SelectTile({
    super.key,
    required this.source,
    this.value,
    required this.onChanged,
    required this.onModelFetch,
    required this.title,
    required this.leadingBuilder,
    required this.dialogBuilder,
    required this.selectBuilder,
  });

  @override
  State<SelectTile<T>> createState() => _SelectTileState();
}

class _SelectTileState<T extends NamedModel> extends State<SelectTile<T>> {
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
    return FutureBuilder<T?>(
        future: Future.value(_value == null
            ? null
            : widget.onModelFetch(widget.source,
                context.read<FlowCubit>().getService(widget.source), _value!)),
        builder: (context, snapshot) {
          final model = snapshot.data;
          final sourcedModel = SourcedModel(widget.source, model);
          return ListTile(
            title: Text(widget.title),
            subtitle: Text(model?.name ?? AppLocalizations.of(context).notSet),
            leading: widget.leadingBuilder(context, sourcedModel),
            onTap: () async {
              if (model != null) {
                Navigator.of(context).pop();
                final newModel = await showDialog<SourcedModel<T>>(
                  context: context,
                  builder: (context) => widget.dialogBuilder(
                    context,
                    SourcedModel(
                      widget.source,
                      model,
                    ),
                  ),
                );
                if (newModel != null) {
                  _onChanged(newModel.model.id);
                }
              } else {
                final newModel = await showDialog<SourcedModel<T>>(
                  context: context,
                  builder: (context) => widget.selectBuilder(
                    context,
                    sourcedModel,
                  ),
                );
                if (newModel != null) {
                  _onChanged(newModel.model.id);
                }
              }
            },
            trailing: _value == null
                ? IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                    onPressed: () async {
                      final selected = await showDialog<SourcedModel<T>>(
                        context: context,
                        builder: (context) => widget.dialogBuilder(
                          context,
                          SourcedModel(
                            widget.source,
                            null,
                          ),
                        ),
                      );
                      if (selected == null) return;
                      _onChanged(selected.model.id);
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

typedef SelectFetchCallback<T> = Future<List<T>?> Function(
    String source, SourceService service, String search, int offset, int limit);

class SelectDialog<T extends NamedModel> extends StatefulWidget {
  final String title;
  final String? source;
  final SourcedModel<Multihash>? selected;
  final SelectFetchCallback<T> onFetch;

  const SelectDialog({
    super.key,
    this.source,
    this.selected,
    required this.onFetch,
    required this.title,
  });

  @override
  State<SelectDialog<T>> createState() => _SelectDialogState();
}

class _SelectDialogState<T extends NamedModel> extends State<SelectDialog<T>> {
  final TextEditingController _controller = TextEditingController();
  late final SourcedPagingController<T> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = SourcedPagingController<T>(
      context.read<FlowCubit>(),
    );

    _pagingController.addFetchListener((source, service, offset, limit) =>
        widget.onFetch(source, service, _controller.text, offset, limit));
  }

  @override
  void dispose() {
    super.dispose();

    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
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
              child: PagedListView(
                pagingController: _pagingController,
                builderDelegate: buildMaterialPagedDelegate<SourcedModel<T>>(
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
