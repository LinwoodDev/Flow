import 'package:flow/widgets/select.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'dart:typed_data';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import 'event.dart';

class EventSelectTile extends StatelessWidget {
  final String? source;
  final Uint8List? value;
  final ValueChanged<SourcedModel<Uint8List>?> onChanged;

  const EventSelectTile({
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
      onModelFetch: (source, service, id) async => service.event?.getEvent(id),
      title: AppLocalizations.of(context).event,
      leadingBuilder: (context, model) => PhosphorIcon(model?.model == null
          ? PhosphorIconsLight.calendar
          : PhosphorIconsFill.calendar),
      dialogBuilder: (context, sourcedModel) => EventDialog(
        source: sourcedModel?.source,
        event: sourcedModel?.model,
        create: sourcedModel?.model == null,
      ),
      selectBuilder: (context, model) => EventSelectDialog(
        selected: model?.toIdentifierModel(),
        source: source,
      ),
    );
  }
}

class EventSelectDialog extends StatelessWidget {
  final String? source;
  final SourcedModel<Uint8List>? selected;

  const EventSelectDialog({
    super.key,
    this.source,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      onFetch: (source, service, search, offset, limit) async =>
          service.event?.getEvents(
        offset: offset,
        limit: limit,
        search: search,
      ),
      title: AppLocalizations.of(context).event,
      selected: selected,
    );
  }
}
