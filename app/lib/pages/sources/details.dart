import 'package:flow/api/storage/remote/model.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flow/visualizer/storage.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'counts.dart';

class SourceDetailsDialog extends StatelessWidget {
  final RemoteStorage source;

  const SourceDetailsDialog({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final description = switch (source) {
      CalDavStorage() => l10n.caldavDescription,
      ICalStorage() => l10n.icalDescription,
      DeviceCalendarStorage() => l10n.deviceCalendarDescription,
      WebDavStorage() => l10n.webdavDescription,
      SiaStorage() => l10n.decentralizedDescription,
    };
    return AlertDialog(
      scrollable: true,
      title: Text(l10n.sourceDetails),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: PhosphorIcon(
                source.icon(PhosphorIconsStyle.light),
                color: theme.colorScheme.primary,
              ),
              title: Text(
                source.displayName,
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(source.getLocalizedName(context)),
            ),
            if (source.isReadOnly)
              Chip(
                label: Text(l10n.readOnly),
                avatar: const PhosphorIcon(PhosphorIconsLight.lock, size: 16),
              ),
            const Divider(),
            SourceItemCounts(source: source.identifier, detailed: true),
            const SizedBox(height: 16),
            _Detail(
              label: l10n.sourceType,
              value: source.getLocalizedName(context),
            ),
            if (source case DeviceCalendarStorage(:final calendarIds))
              _Detail(
                label: l10n.calendar,
                value: calendarIds.isEmpty
                    ? l10n.allDeviceCalendars
                    : '${l10n.selectedCalendars}\n${calendarIds.join('\n')}',
              )
            else ...[
              _Detail(label: l10n.url, value: source.url),
              if (source.username.isNotEmpty)
                _Detail(label: l10n.username, value: source.username),
            ],
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.sourceBehavior, style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  Text(description),
                ],
              ),
            ),
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

class _Detail extends StatelessWidget {
  final String label;
  final String value;

  const _Detail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 4),
        SelectableText(value),
      ],
    ),
  );
}
