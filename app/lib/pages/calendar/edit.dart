import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/event/model.dart';

import '../../widgets/date_time_field.dart';

class EditEventDialog extends StatelessWidget {
  final String source;
  final Event event;

  const EditEventDialog({super.key, required this.event, required this.source});

  @override
  Widget build(BuildContext context) {
    var event = this.event;
    TextEditingController nameController =
        TextEditingController(text: event.name);
    TextEditingController descriptionController =
        TextEditingController(text: event.description);
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.editEvent),
      scrollable: true,
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            ),
            const SizedBox(height: 8),
            DateTimeField(
              label: AppLocalizations.of(context)!.end,
              initialValue: event.end,
              icon: const Icon(Icons.calendar_today_outlined),
              onChanged: (value) {
                event = event.copyWith(end: value);
              },
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
            context
                .read<FlowCubit>()
                .getSource(source)
                .event
                .updateEvent(event);
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
