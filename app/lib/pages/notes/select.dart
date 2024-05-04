import 'package:flow/widgets/select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import 'label.dart';

class LabelSelectTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SelectTile(
      source: source,
      onChanged: onChanged,
      onModelFetch: (source, service, id) async => service.label?.getLabel(id),
      title: AppLocalizations.of(context).label,
      leadingBuilder: (context, model) => PhosphorIcon(
          model.model == null ? PhosphorIconsLight.tag : PhosphorIconsFill.tag),
      dialogBuilder: (context, sourcedModel) => LabelDialog(
        source: sourcedModel.source,
        label: sourcedModel.model,
        create: sourcedModel.model == null,
      ),
      selectBuilder: (context, model) => LabelSelectDialog(
        selected: model.toIdentifierModel(),
        source: source,
      ),
    );
  }
}

class LabelSelectDialog extends StatelessWidget {
  final String? source;
  final SourcedModel<Multihash>? selected;

  const LabelSelectDialog({
    super.key,
    this.source,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      onFetch: (source, service, search, offset, limit) async =>
          service.label?.getLabels(
        offset: offset,
        limit: limit,
        search: search,
      ),
      title: AppLocalizations.of(context).label,
      selected: selected,
    );
  }
}
