import 'package:flow/pages/notes/note.dart';
import 'package:flow/widgets/select.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'dart:typed_data';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import 'label.dart';

class LabelSelectTile extends StatelessWidget {
  final String? source;
  final Uint8List? value;
  final ValueChanged<SourcedModel<Uint8List>?> onChanged;

  const LabelSelectTile({
    super.key,
    this.source,
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
      leadingBuilder: (context, model) => PhosphorIcon(model?.model == null
          ? PhosphorIconsLight.tag
          : PhosphorIconsFill.tag),
      dialogBuilder: (context, sourcedModel) => LabelDialog(
        source: sourcedModel?.source,
        label: sourcedModel?.model,
        create: sourcedModel?.model == null,
      ),
      selectBuilder: (context, model) => LabelSelectDialog(
        selected: model?.toIdentifierModel(),
        source: source,
      ),
    );
  }
}

class LabelSelectDialog extends StatelessWidget {
  final String? source;
  final SourcedModel<Uint8List>? selected;

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

class NoteSelectDialog extends StatelessWidget {
  final String? source;
  final SourcedModel<Uint8List>? selected;

  const NoteSelectDialog({
    super.key,
    this.source,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      onFetch: (source, service, search, offset, limit) async =>
          service.note?.getNotes(
        offset: offset,
        limit: limit,
        search: search,
      ),
      onCreate: (source) => showDialog<SourcedModel<Note>>(
        context: context,
        builder: (context) => NoteDialog(
          source: source,
          note: null,
          create: true,
        ),
      ),
      title: AppLocalizations.of(context).note,
      selected: selected,
    );
  }
}
