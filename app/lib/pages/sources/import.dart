import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/event/model.dart';

class ImportDialog extends StatelessWidget {
  final List<Event> events;

  const ImportDialog({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).confirmImport),
      content: Text(AppLocalizations.of(context).countEvents(events.length)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.of(context).import),
        ),
      ],
    );
  }
}
