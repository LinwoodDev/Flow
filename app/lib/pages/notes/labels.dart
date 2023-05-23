import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flow/pages/notes/label.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/label/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';

class LabelsDrawer extends StatefulWidget {
  const LabelsDrawer({super.key});

  @override
  State<LabelsDrawer> createState() => _LabelsDrawerState();
}

class _LabelsDrawerState extends State<LabelsDrawer> {
  late final SourcedPagingController<Label> _pagingController;
  String _search = '';

  @override
  void initState() {
    super.initState();
    final cubit = context.read<FlowCubit>();
    _pagingController = SourcedPagingController(cubit);
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
          Expanded(
              child: PagedListView(
                  pagingController: _pagingController,
                  builderDelegate:
                      buildMaterialPagedDelegate<SourcedModel<Label>>(
                          _pagingController,
                          (context, item, index) =>
                              ListTile(title: Text(item.model.name))))),
          const Divider(),
          OutlinedButton.icon(
            icon: const PhosphorIcon(PhosphorIconsLight.plus),
            label: Text(AppLocalizations.of(context).createLabel),
            onPressed: () => showDialog(
                context: context, builder: (context) => const LabelDialog()),
          )
        ]),
      ),
    );
  }
}

class LabelDialog extends StatelessWidget {
  final String? source;
  final Label? label;
  final bool create;

  const LabelDialog({super.key, this.create = false, this.label, this.source});

  @override
  Widget build(BuildContext context) {
    final create = this.create || label == null || source == null;
    return AlertDialog(
      title: Text(create
          ? AppLocalizations.of(context).createLabel
          : AppLocalizations.of(context).editLabel),
    );
  }
}
