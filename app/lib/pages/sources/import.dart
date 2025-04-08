import 'package:flow_api/models/event/item/model.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow_api/models/event/model.dart';

class ImportDialog extends StatelessWidget {
  final List<Event> events;
  final List<CalendarItem> items;

  const ImportDialog({super.key, required this.events, required this.items});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).confirmImport),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context).countEvents(events.length)),
          const SizedBox(height: 8),
          Text(AppLocalizations.of(context).countItems(items.length)),
        ],
      ),
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
