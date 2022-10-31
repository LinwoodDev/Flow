import 'package:flow/cubits/flow.dart';
import 'package:flow/widgets/date_time_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateEventDialog extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  CreateEventDialog({super.key});

  @override
  Widget build(BuildContext context) {
    String source = context.read<FlowCubit>().getCurrentSource();
    DateTime start = DateTime.now(), end = DateTime.now();
    return AlertDialog(
      scrollable: true,
      title: Text(AppLocalizations.of(context)!.createEvent),
      content: SizedBox(
        width: 500,
        child: Column(children: [
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
              source = value ?? '';
            },
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.source,
              icon: const Icon(Icons.storage_outlined),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              filled: true,
              labelText: AppLocalizations.of(context)!.name,
              icon: const Icon(Icons.folder_outlined),
            ),
            controller: _titleController,
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
            controller: _descriptionController,
          ),
          const SizedBox(height: 16),
          DateTimeField(
            label: AppLocalizations.of(context)!.start,
            icon: const Icon(Icons.calendar_today_outlined),
            onChanged: (value) => start = value,
            initialValue: start,
          ),
          const SizedBox(height: 8),
          DateTimeField(
            label: AppLocalizations.of(context)!.end,
            icon: const Icon(Icons.calendar_today_outlined),
            onChanged: (value) => end = value,
            initialValue: end,
          ),
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<FlowCubit>().getSource(source).event.createEvent(
                  name: _titleController.text,
                  description: _descriptionController.text,
                  start: DateTime.now(),
                  end: DateTime.now(),
                );
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.create),
        )
      ],
    );
  }
}
