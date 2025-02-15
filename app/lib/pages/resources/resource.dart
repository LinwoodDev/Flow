import 'package:flow/widgets/markdown_field.dart';
import 'package:flow_api/models/resource/model.dart';
import 'package:flow_api/models/resource/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/source_dropdown.dart';

class ResourceDialog extends StatelessWidget {
  final String? source;
  final Resource? resource;
  final bool create;

  const ResourceDialog({
    super.key,
    this.source,
    this.resource,
    this.create = false,
  });

  @override
  Widget build(BuildContext context) {
    final create = this.create || resource == null || source == null;
    var currentResource = resource ?? const Resource();
    var currentSource = source ?? '';
    var currentService =
        context.read<FlowCubit>().getService(currentSource).resource;
    return ResponsiveAlertDialog(
      title: Text(create
          ? AppLocalizations.of(context).createResource
          : AppLocalizations.of(context).editResource),
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
      content: ListView(shrinkWrap: true, children: [
        if (source == null) ...[
          SourceDropdown<ResourceService>(
            value: currentSource,
            buildService: (e) => e.resource,
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
          initialValue: currentResource.name,
          onChanged: (value) {
            currentResource = currentResource.copyWith(name: value);
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).location,
            filled: true,
            icon: const PhosphorIcon(PhosphorIconsLight.mapPin),
          ),
          initialValue: currentResource.address,
          onChanged: (value) {
            currentResource = currentResource.copyWith(address: value);
          },
        ),
        const SizedBox(height: 16),
        MarkdownField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).description,
            border: const OutlineInputBorder(),
            icon: const PhosphorIcon(PhosphorIconsLight.fileText),
          ),
          value: currentResource.description,
          onChanged: (value) {
            currentResource = currentResource.copyWith(description: value);
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
              final created =
                  await currentService?.createResource(currentResource);
              if (created == null) {
                return;
              }
              currentResource = created;
            } else {
              await currentService?.updateResource(currentResource);
            }
            if (context.mounted) {
              Navigator.of(context).pop(currentResource);
            }
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
