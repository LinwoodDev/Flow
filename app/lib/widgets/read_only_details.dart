import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';

/// A view-only alternative to an editor for subscription data.
class ReadOnlyDetails extends StatelessWidget {
  final String name;
  final String description;
  final String location;
  final String? schedule;

  const ReadOnlyDetails({
    super.key,
    required this.name,
    this.description = '',
    this.location = '',
    this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      scrollable: true,
      title: Text(name.isEmpty ? l10n.readOnly : name),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.readOnlySourceDescription),
            if (schedule != null) ...[
              const SizedBox(height: 16),
              SelectableText(schedule!),
            ],
            if (location.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                l10n.location,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SelectableText(location),
            ],
            if (description.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                l10n.description,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SelectableText(description),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.close),
        ),
      ],
    );
  }
}
