import 'package:flow/pages/notes/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/note/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/paging/error.dart';

class DashboardNotesView extends StatefulWidget {
  const DashboardNotesView({super.key});

  @override
  State<DashboardNotesView> createState() => _DashboardNotesViewState();
}

class _DashboardNotesViewState extends State<DashboardNotesView> {
  late Future<List<(Note, String)>> _notesFuture;

  @override
  void initState() {
    super.initState();
    _notesFuture = _getNotes();
  }

  Future<List<(Note, String)>> _getNotes() async {
    final sources = context.read<FlowCubit>().getCurrentServicesMap();
    final notes = <(Note, String)>[];
    for (final source in sources.entries) {
      notes.addAll(
        (await source.value.note?.getNotes(limit: 5) ?? [])
            .map((e) => (e, source.key))
            .toList(),
      );
    }
    notes.sort((a, b) {
      final priorityComparison = b.$1.priority.compareTo(a.$1.priority);
      if (priorityComparison != 0) return priorityComparison;
      return a.$1.name.compareTo(b.$1.name);
    });
    return notes;
  }

  void _refresh() {
    if (!mounted) return;
    setState(() => _notesFuture = _getNotes());
  }

  @override
  void didUpdateWidget(covariant DashboardNotesView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _notesFuture = _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context).notes,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            IconButton(
              tooltip: AppLocalizations.of(context).refresh,
              icon: const PhosphorIcon(PhosphorIconsLight.arrowClockwise),
              onPressed: _refresh,
            ),
            IconButton(
              tooltip: AppLocalizations.of(context).notes,
              icon: const PhosphorIcon(PhosphorIconsLight.arrowSquareOut),
              onPressed: () => GoRouter.of(context).go('/notes'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: FutureBuilder<List<(Note, String)>>(
            future: _notesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return ErrorIndicatorDisplay(onTryAgain: _refresh);
              }
              final notes = snapshot.data ?? <(Note, String)>[];
              if (notes.isEmpty) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context).indicatorEmpty,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              return ListView(
                children: notes
                    .map((e) => NoteListTile(note: e.$1, source: e.$2))
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
