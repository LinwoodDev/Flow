import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/event/model.dart';

class EventGroupPropertyDialog extends StatelessWidget {
  final String? source;
  final EventGroup? eventGroup;

  const EventGroupPropertyDialog({super.key, this.eventGroup, this.source});

  @override
  Widget build(BuildContext context) {
    var eventGroup = this.eventGroup ?? const EventGroup();
    var currentSource = source ?? '';
    final nameController = TextEditingController(text: eventGroup.name);
    final descriptionController =
        TextEditingController(text: eventGroup.description);
    return AlertDialog(
      title: Text(source == null
          ? AppLocalizations.of(context)!.createGroup
          : AppLocalizations.of(context)!.editGroup),
      content: SizedBox(
        width: 500,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              labelText: AppLocalizations.of(context)!.name,
              icon: const Icon(Icons.folder_outlined),
            ),
            controller: nameController,
            onChanged: (value) {
              eventGroup = eventGroup.copyWith(name: value);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.description,
              border: const OutlineInputBorder(),
              icon: const Icon(Icons.description_outlined),
            ),
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            onChanged: (value) {
              eventGroup = eventGroup.copyWith(description: value);
            },
          )
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (source == null) {
              context
                  .read<FlowCubit>()
                  .getSource(currentSource)
                  .eventGroup
                  .createGroup(eventGroup);
            } else {
              context
                  .read<FlowCubit>()
                  .getSource(source!)
                  .eventGroup
                  .updateGroup(eventGroup);
            }
            Navigator.of(context).pop(eventGroup);
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
