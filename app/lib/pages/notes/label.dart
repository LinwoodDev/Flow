import 'package:flow/widgets/markdown_field.dart';
import 'package:flow/widgets/save_dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/label/model.dart';
import 'package:flow_api/models/label/service.dart';

import '../../cubits/flow.dart';
import '../../widgets/source_dropdown.dart';

class LabelDialog extends StatelessWidget {
  final String? source;
  final Label? label;
  final bool create;

  const LabelDialog({super.key, this.source, this.label, this.create = false});

  @override
  Widget build(BuildContext context) {
    final create = this.create || label == null || source == null;
    var currentLabel = label ?? const Label();
    var currentSource = source ?? '';
    var currentService = context
        .read<FlowCubit>()
        .getService(currentSource)
        .label;
    return ResponsiveAlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatefulBuilder(
            builder: (context, setState) => ColorButton.srgb(
              onTap: () async {
                final result = await showDialog<ColorPickerResponse>(
                  context: context,
                  builder: (context) => ColorPicker(value: currentLabel.color),
                );
                if (result == null) return;
                setState(
                  () => currentLabel = currentLabel.copyWith(
                    color: result.toSRGB(),
                  ),
                );
              },
              color: currentLabel.color.withOpacity(1),
              size: 25,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            create
                ? AppLocalizations.of(context).createLabel
                : AppLocalizations.of(context).editLabel,
          ),
        ],
      ),
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: ListView(
        shrinkWrap: true,
        children: [
          if (source == null) ...[
            SourceDropdown<LabelService>(
              value: currentSource,
              buildService: (e) => e.label,
              onChanged: (connected) {
                currentSource = connected?.source ?? '';
                currentService = connected?.model;
              },
            ),
            const SizedBox(height: 16),
          ],
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).name,
              filled: true,
              icon: const PhosphorIcon(PhosphorIconsLight.textT),
            ),
            initialValue: currentLabel.name,
            onChanged: (value) {
              currentLabel = currentLabel.copyWith(name: value);
            },
          ),
          const SizedBox(height: 16),
          MarkdownField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).description,
              border: const OutlineInputBorder(),
              icon: const PhosphorIcon(PhosphorIconsLight.fileText),
            ),
            value: currentLabel.description,
            onChanged: (value) {
              currentLabel = currentLabel.copyWith(description: value);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        SaveDialogButton<SourcedModel<Label>>(
          errorMessage: AppLocalizations.of(context).saveFailed,
          onSave: () async {
            final service = currentService;
            if (service == null) return null;
            if (create) {
              final created = await service.createLabel(currentLabel);
              if (created == null) return null;
              currentLabel = created;
            } else {
              final updated = await service.updateLabel(currentLabel);
              if (!updated) return null;
            }
            return SourcedModel<Label>(currentSource, currentLabel);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
