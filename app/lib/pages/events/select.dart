import 'package:flow/widgets/select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import 'event.dart';

class EventSelectTile extends StatelessWidget {
  final String? source;
  final Multihash? value;
  final ValueChanged<SourcedModel<Multihash>?> onChanged;

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
  final SourcedModel<Multihash>? selected;

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
