import 'package:flow/widgets/select.dart';
import 'package:flow_api/models/resource/model.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'dart:typed_data';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import 'resource.dart';

class ResourceSelectTile extends StatelessWidget {
  final String? source;
  final Uint8List? value;
  final ValueChanged<SourcedModel<Uint8List>?> onChanged;

  const ResourceSelectTile({
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
      onModelFetch: (source, service, id) async =>
          service.resource?.getResource(id),
      title: AppLocalizations.of(context).resource,
      leadingBuilder: (context, model) => PhosphorIcon(
        model?.model == null ? PhosphorIconsLight.cube : PhosphorIconsFill.cube,
      ),
      dialogBuilder: (context, sourcedModel) => ResourceDialog(
        source: sourcedModel?.source,
        resource: sourcedModel?.model,
        create: sourcedModel?.model == null,
      ),
      selectBuilder: (context, model) => ResourceSelectDialog(
        selected: model?.toIdentifierModel(),
        source: source,
      ),
    );
  }
}

class ResourceSelectDialog extends StatelessWidget {
  final String? source;
  final SourcedModel<Uint8List>? selected;

  const ResourceSelectDialog({super.key, this.source, this.selected});

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      onFetch: (source, service, search, offset, limit) async => service
          .resource
          ?.getResources(offset: offset, limit: limit, search: search),
      onCreate: (source) => showDialog<SourcedModel<Resource>>(
        context: context,
        builder: (context) => ResourceDialog(source: source, create: true),
      ),
      title: AppLocalizations.of(context).resource,
      selected: selected,
    );
  }
}
