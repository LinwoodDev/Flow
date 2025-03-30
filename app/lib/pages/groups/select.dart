import 'package:flow/widgets/select.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'dart:typed_data';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import 'group.dart';

class GroupSelectTile extends StatelessWidget {
  final String source;
  final Uint8List? value;
  final ValueChanged<SourcedModel<Uint8List>?> onChanged;

  const GroupSelectTile({
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
      onModelFetch: (source, service, id) async => service.group?.getGroup(id),
      title: AppLocalizations.of(context).group,
      leadingBuilder: (context, model) => PhosphorIcon(model?.model == null
          ? PhosphorIconsLight.users
          : PhosphorIconsFill.users),
      dialogBuilder: (context, sourcedModel) => GroupDialog(
        source: sourcedModel?.source,
        group: sourcedModel?.model,
        create: sourcedModel?.model == null,
      ),
      selectBuilder: (context, model) => GroupSelectDialog(
        selected: model?.toIdentifierModel(),
        source: source,
      ),
    );
  }
}

class GroupSelectDialog extends StatelessWidget {
  final String? source;
  final SourcedModel<Uint8List>? selected;

  const GroupSelectDialog({
    super.key,
    this.source,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      onFetch: (source, service, search, offset, limit) async =>
          service.group?.getGroups(
        offset: offset,
        limit: limit,
        search: search,
      ),
      onCreate: (source) => showDialog<SourcedModel<Group>>(
        context: context,
        builder: (context) => GroupDialog(
          source: source,
          group: null,
          create: true,
        ),
      ),
      title: AppLocalizations.of(context).group,
      selected: selected,
    );
  }
}
