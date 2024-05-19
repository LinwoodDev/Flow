import 'package:flow/widgets/markdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/place/model.dart';
import 'package:flow_api/models/place/service.dart';

import '../../cubits/flow.dart';
import '../../widgets/source_dropdown.dart';

class PlaceDialog extends StatelessWidget {
  final String? source;
  final Place? place;
  final bool create;

  const PlaceDialog({
    super.key,
    this.source,
    this.place,
    this.create = false,
  });

  @override
  Widget build(BuildContext context) {
    final create = this.create || place == null || source == null;
    var currentPlace = place ?? const Place();
    var currentSource = source ?? '';
    var currentService =
        context.read<FlowCubit>().getService(currentSource).place;
    return ResponsiveAlertDialog(
      title: Text(create
          ? AppLocalizations.of(context).createPlace
          : AppLocalizations.of(context).editPlace),
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
      content: ListView(shrinkWrap: true, children: [
        if (source == null) ...[
          SourceDropdown<PlaceService>(
            value: currentSource,
            buildService: (e) => e.place,
            onChanged: (connected) {
              currentSource = connected?.source ?? '';
            },
          ),
          const SizedBox(height: 16),
        ],
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).name,
            filled: true,
            icon: const PhosphorIcon(PhosphorIconsLight.fileText),
          ),
          initialValue: currentPlace.name,
          onChanged: (value) {
            currentPlace = currentPlace.copyWith(name: value);
          },
        ),
        const SizedBox(height: 16),
        MarkdownField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).description,
            border: const OutlineInputBorder(),
            icon: const PhosphorIcon(PhosphorIconsLight.fileText),
          ),
          value: currentPlace.description,
          onChanged: (value) {
            currentPlace = currentPlace.copyWith(description: value);
          },
        )
      ]),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            if (create) {
              final created = await currentService?.createPlace(currentPlace);
              if (created == null) {
                return;
              }
              currentPlace = created;
            } else {
              await currentService?.updatePlace(currentPlace);
            }
            if (context.mounted) {
              Navigator.of(context)
                  .pop(SourcedModel(currentSource, currentPlace));
            }
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
