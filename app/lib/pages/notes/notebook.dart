import 'package:flow/widgets/markdown_field.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flow_api/models/note/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/source_dropdown.dart';

class NotebookDialog extends StatelessWidget {
  final String? source;
  final Notebook? notebook;
  final bool create;

  const NotebookDialog({
    super.key,
    this.source,
    this.notebook,
    this.create = false,
  });

  @override
  Widget build(BuildContext context) {
    final create = this.create || notebook == null || source == null;
    var currentNotebook = notebook ?? const Notebook();
    var currentSource = source ?? '';
    var currentService =
        context.read<FlowCubit>().getService(currentSource).note;
    return AlertDialog(
      title: Text(create
          ? AppLocalizations.of(context).createNotebook
          : AppLocalizations.of(context).editNotebook),
      content: SizedBox(
        width: 500,
        child: Column(children: [
          if (source == null) ...[
            SourceDropdown<NoteService>(
              value: currentSource,
              buildService: (e) => e.note,
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
            initialValue: currentNotebook.name,
            onChanged: (value) {
              currentNotebook = currentNotebook.copyWith(name: value);
            },
          ),
          const SizedBox(height: 16),
          MarkdownField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).description,
              border: const OutlineInputBorder(),
              icon: const PhosphorIcon(PhosphorIconsLight.fileText),
            ),
            value: currentNotebook.description,
            onChanged: (value) {
              currentNotebook = currentNotebook.copyWith(description: value);
            },
          )
        ]),
      ),
      scrollable: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            if (create) {
              final created =
                  await currentService?.createNotebook(currentNotebook);
              if (created == null) {
                return;
              }
              currentNotebook = created;
            } else {
              await currentService?.updateNotebook(currentNotebook);
            }
            if (context.mounted) {
              Navigator.of(context)
                  .pop(SourcedModel(currentSource, currentNotebook));
            }
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
