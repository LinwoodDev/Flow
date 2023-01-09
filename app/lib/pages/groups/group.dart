import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/group/model.dart';

class GroupDialog extends StatelessWidget {
  final String? source;
  final Group? group;

  const GroupDialog({super.key, this.group, this.source});

  @override
  Widget build(BuildContext context) {
    var group = this.group ?? const Group();
    var currentSource = source ?? '';
    final nameController = TextEditingController(text: group.name);
    final descriptionController =
        TextEditingController(text: group.description);
    return AlertDialog(
      title: Text(source == null
          ? AppLocalizations.of(context).createGroup
          : AppLocalizations.of(context).editGroup),
      content: SizedBox(
        width: 500,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (source == null) ...[
            DropdownButtonFormField<String>(
              value: source,
              items: context
                  .read<FlowCubit>()
                  .getCurrentSources()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.isEmpty
                      ? AppLocalizations.of(context).local
                      : value),
                );
              }).toList(),
              onChanged: (String? value) {
                currentSource = value ?? '';
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).source,
                icon: const Icon(Icons.storage_outlined),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
          ],
          TextField(
            decoration: InputDecoration(
              filled: true,
              labelText: AppLocalizations.of(context).name,
              icon: const Icon(Icons.folder_outlined),
            ),
            controller: nameController,
            onChanged: (value) {
              group = group.copyWith(name: value);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).description,
              border: const OutlineInputBorder(),
              icon: const Icon(Icons.description_outlined),
            ),
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            onChanged: (value) {
              group = group.copyWith(description: value);
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
          onPressed: () {
            if (source == null) {
              context
                  .read<FlowCubit>()
                  .getSource(currentSource)
                  .group
                  .createGroup(group);
            } else {
              context
                  .read<FlowCubit>()
                  .getSource(source!)
                  .group
                  .updateGroup(group);
            }
            Navigator.of(context).pop(group);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
