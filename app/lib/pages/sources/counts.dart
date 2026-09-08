import 'dart:async';

import 'package:flow/api/storage/sources.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SourceItemCounts extends StatefulWidget {
  final String source;
  final bool detailed;

  const SourceItemCounts({super.key, this.source = '', this.detailed = false});

  @override
  State<SourceItemCounts> createState() => _SourceItemCountsState();
}

class _SourceItemCountsState extends State<SourceItemCounts> {
  late final SourcesService _sources;
  late Future<Map<String, int>> _counts;
  StreamSubscription<SyncState>? _subscription;

  @override
  void initState() {
    super.initState();
    _sources = context.read<SourcesService>();
    _counts = _sources.getItemCounts(widget.source);
    _subscription = _sources.syncState.listen((_) {
      if (mounted) {
        setState(() {
          _counts = _sources.getItemCounts(widget.source);
        });
      }
    });
  }

  @override
  void didUpdateWidget(SourceItemCounts oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source) {
      _counts = _sources.getItemCounts(widget.source);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FutureBuilder<Map<String, int>>(
      future: _counts,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(l10n.sourceCountsUnavailable);
        final counts = snapshot.data;
        if (counts == null) return Text(l10n.loading);
        final total = counts.values.fold(0, (sum, count) => sum + count);
        if (!widget.detailed) return Text(l10n.storedItems(total));
        final labels = {
          'events': l10n.events,
          'calendarItems': l10n.calendarEntries,
          'notes': l10n.notes,
          'notebooks': l10n.notebooks,
          'resources': l10n.resources,
          'users': l10n.users,
          'groups': l10n.groups,
          'labels': l10n.labels,
        };
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.storedItems(total),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: counts.entries
                  .map(
                    (entry) => Chip(
                      label: Text('${labels[entry.key]}: ${entry.value}'),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.storedItemsDescription,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}
