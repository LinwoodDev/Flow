import 'package:flow/cubits/flow.dart';
import 'package:flow/widgets/source_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/group/service.dart';

class GroupDialog extends StatelessWidget {
  final String? source;
  final Group? group;

  const GroupDialog({super.key, this.group, this.source});

  @override
  Widget build(BuildContext context) {
    var group = this.group ?? const Group();
    var currentSource = source ?? '';
    var currentService =
        context.read<FlowCubit>().getService(currentSource).group;
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
              currentService?.createGroup(group);
            } else {
              currentService?.updateGroup(group);
            }
            Navigator.of(context).pop(group);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
