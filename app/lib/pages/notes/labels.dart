import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flow/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/label/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import 'label.dart';

class LabelsDrawer extends StatefulWidget {
  final Multihash? selected;
  final void Function(SourcedModel<Label>, bool)? onChanged;

  const LabelsDrawer({super.key, this.selected, this.onChanged});

  @override
  State<LabelsDrawer> createState() => _LabelsDrawerState();
}

class _LabelsDrawerState extends State<LabelsDrawer> {
  late final SourcedPagingController<Label> _pagingController;
  String _search = '';
  late final FlowCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FlowCubit>();
    _pagingController = SourcedPagingController(_cubit);
    _pagingController.addFetchListener((source, service, offset, limit) async =>
        await service.label
            ?.getLabels(offset: offset, limit: limit, search: _search));
  }

  @override
  void dispose() {
    super.dispose();

    _pagingController.dispose();
  }

  @override
  void didUpdateWidget(covariant LabelsDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      setState(() {});
      _pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).search,
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              _search = value;
              _pagingController.refresh();
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: PagedListView(
              pagingController: _pagingController,
              builderDelegate: buildMaterialPagedDelegate<SourcedModel<Label>>(
                _pagingController,
                (context, item, index) {
                  final selected = widget.selected == item.model.id;
                  return ListTile(
                    title: Text(item.model.name),
                    onTap: () {
                      widget.onChanged?.call(item, !selected);
                    },
                    selected: selected,
                    leading: ColorPoint(
                        color: Color(item.model.color).withAlpha(255)),
                    trailing: MenuAnchor(
                      menuChildren: [
                        MenuItemButton(
                            leadingIcon:
                                const PhosphorIcon(PhosphorIconsLight.pencil),
                            child: Text(AppLocalizations.of(context).edit),
                            onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) =>
                                        LabelDialog(label: item.model))
                                .then((value) => _pagingController.refresh())),
                        MenuItemButton(
                          leadingIcon:
                              const PhosphorIcon(PhosphorIconsLight.trash),
                          child: Text(AppLocalizations.of(context).delete),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(AppLocalizations.of(context)
                                  .deleteLabel(item.model.name)),
                              content: Text(AppLocalizations.of(context)
                                  .deleteLabelDescription(item.model.name)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child:
                                      Text(AppLocalizations.of(context).cancel),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final id = item.model.id;
                                    if (id == null) return;
                                    await _cubit
                                        .getService(item.source)
                                        .label
                                        ?.deleteLabel(id);
                                    _pagingController.refresh();
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child:
                                      Text(AppLocalizations.of(context).delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      builder: (context, controller, child) => IconButton(
                        icon: const PhosphorIcon(
                            PhosphorIconsLight.dotsThreeVertical),
                        onPressed: () => controller.isOpen
                            ? controller.close()
                            : controller.open(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const Divider(),
          OutlinedButton.icon(
            icon: const PhosphorIcon(PhosphorIconsLight.plus),
            label: Text(AppLocalizations.of(context).createLabel),
            onPressed: () => showDialog(
                    context: context, builder: (context) => const LabelDialog())
                .then((value) => _pagingController.refresh()),
          )
        ]),
      ),
    );
  }
}
