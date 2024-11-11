import 'package:flow/widgets/select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:typed_data';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import 'place.dart';

class PlaceSelectTile extends StatelessWidget {
  final String? source;
  final Uint8List? value;
  final ValueChanged<SourcedModel<Uint8List>?> onChanged;

  const PlaceSelectTile({
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
      onModelFetch: (source, service, id) async => service.place?.getPlace(id),
      title: AppLocalizations.of(context).place,
      leadingBuilder: (context, model) => PhosphorIcon(model?.model == null
          ? PhosphorIconsLight.mapPin
          : PhosphorIconsFill.mapPin),
      dialogBuilder: (context, sourcedModel) => PlaceDialog(
        source: sourcedModel?.source,
        place: sourcedModel?.model,
        create: sourcedModel?.model == null,
      ),
      selectBuilder: (context, model) => PlaceSelectDialog(
        selected: model?.toIdentifierModel(),
        source: source,
      ),
    );
  }
}

class PlaceSelectDialog extends StatelessWidget {
  final String? source;
  final SourcedModel<Uint8List>? selected;

  const PlaceSelectDialog({
    super.key,
    this.source,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      onFetch: (source, service, search, offset, limit) async =>
          service.place?.getPlaces(
        offset: offset,
        limit: limit,
        search: search,
      ),
      title: AppLocalizations.of(context).place,
      selected: selected,
    );
  }
}
