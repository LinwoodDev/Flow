import 'package:flow/widgets/select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import 'group.dart';

class GroupSelectTile extends StatelessWidget {
  final String source;
  final Multihash? value;
  final ValueChanged<SourcedModel<Multihash>?> onChanged;

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
  final SourcedModel<Multihash>? selected;

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
      title: AppLocalizations.of(context).group,
      selected: selected,
    );
  }
}
