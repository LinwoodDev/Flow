import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/event/model.dart';

import '../../widgets/date_time_field.dart';

class EventDialog extends StatelessWidget {
  final String? source;
  final Event? event;

  const EventDialog({super.key, this.event, this.source});

  @override
  Widget build(BuildContext context) {
    var event = this.event ?? const Event();
    var currentSource = source ?? '';
    TextEditingController nameController =
        TextEditingController(text: event.name);
    TextEditingController descriptionController =
        TextEditingController(text: event.description);
    return AlertDialog(
      title: Text(source == null
          ? AppLocalizations.of(context)!.createEvent
          : AppLocalizations.of(context)!.editEvent),
      scrollable: true,
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (source == null) ...[
              DropdownButtonFormField<String>(
                value: source,
                items: <String>['', 'Google', 'Outlook', 'iCloud']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.isEmpty
                        ? AppLocalizations.of(context)!.local
                        : value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  currentSource = value ?? '';
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.source,
                  icon: const Icon(Icons.storage_outlined),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                icon: const Icon(Icons.folder_outlined),
              ),
              onChanged: (value) => event = event.copyWith(name: value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
                border: const OutlineInputBorder(),
                icon: const Icon(Icons.description_outlined),
              ),
              minLines: 3,
              maxLines: 5,
              controller: descriptionController,
              onChanged: (value) => event = event.copyWith(description: value),
            ),
            const SizedBox(height: 16),
            DateTimeField(
              label: AppLocalizations.of(context)!.start,
              initialValue: event.start,
              icon: const Icon(Icons.calendar_today_outlined),
              onChanged: (value) {
                event = event.copyWith(start: value);
              },
              canBeEmpty: true,
            ),
            const SizedBox(height: 8),
            DateTimeField(
              label: AppLocalizations.of(context)!.end,
              initialValue: event.end,
              icon: const Icon(Icons.calendar_today_outlined),
              onChanged: (value) {
                event = event.copyWith(end: value);
              },
              canBeEmpty: true,
            ),
          ],
        ),
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
                  .event
                  .createEvent(event);
            } else {
              context
                  .read<FlowCubit>()
                  .getSource(source!)
                  .event
                  .updateEvent(event);
            }
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
