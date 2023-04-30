import 'package:flow/cubits/flow.dart';
import 'package:flow/widgets/markdown_field.dart';
import 'package:flow/widgets/source_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/group/service.dart';
import 'package:shared/models/model.dart';

class GroupDialog extends StatelessWidget {
  final String? source;
  final Group? group;
  final bool create;

  const GroupDialog({
    super.key,
    this.group,
    this.source,
    this.create = false,
  });

  @override
  Widget build(BuildContext context) {
    final create = this.create || group == null || source == null;
    var currentGroup = group ?? const Group();
    var currentSource = source ?? '';
    var currentService =
        context.read<FlowCubit>().getService(currentSource).group;
    final nameController = TextEditingController(text: currentGroup.name);
    return AlertDialog(
      title: Text(create
          ? AppLocalizations.of(context).createGroup
          : AppLocalizations.of(context).editGroup),
      content: SizedBox(
        width: 500,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (source == null) ...[
            SourceDropdown<GroupService>(
              value: currentSource,
              buildService: (e) => e.group,
              onChanged: (connected) {
                currentSource = connected?.source ?? '';
                currentService = connected?.model;
              },
            ),
            const SizedBox(height: 16),
          ],
          TextField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).name,
              icon: const Icon(Icons.folder_outlined),
              filled: true,
            ),
            controller: nameController,
            onChanged: (value) {
              currentGroup = currentGroup.copyWith(name: value);
            },
          ),
          const SizedBox(height: 16),
          MarkdownField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).description,
              border: const OutlineInputBorder(),
              icon: const Icon(Icons.description_outlined),
            ),
            value: currentGroup.description,
            onChanged: (value) {
              currentGroup = currentGroup.copyWith(description: value);
            },
          )
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            if (create) {
              final created = await currentService?.createGroup(currentGroup);
              if (created == null) {
                return;
              }
              currentGroup = created;
            } else {
              await currentService?.updateGroup(currentGroup);
            }
            if (context.mounted) {
              Navigator.of(context)
                  .pop(SourcedModel(currentSource, currentGroup));
            }
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
