import 'package:flow/pages/notes/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/note/model.dart';

import '../../cubits/flow.dart';

class DashboardNotesCard extends StatefulWidget {
  const DashboardNotesCard({super.key});

  @override
  State<DashboardNotesCard> createState() => _DashboardNotesCardState();
}

class _DashboardNotesCardState extends State<DashboardNotesCard> {
  Future<List<(Note, String)>> _getNotes(BuildContext context) async {
    final sources = context.read<FlowCubit>().getCurrentServicesMap();
    final notes = <(Note, String)>[];
    for (final source in sources.entries) {
      notes.addAll((await source.value.note?.getNotes(limit: 5) ?? [])
          .map((e) => (e, source.key))
          .toList());
    }
    return notes;
  }

  @override
  void didUpdateWidget(covariant DashboardNotesCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
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
              icon: const PhosphorIcon(PhosphorIconsLight.arrowSquareOut),
              onPressed: () => GoRouter.of(context).go('/notes'),
            )
          ],
        ),
        const SizedBox(height: 20),
        FutureBuilder<List<(Note, String)>>(
            future: _getNotes(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              final notes = snapshot.data!;
              return Column(
                children: notes
                    .map((e) => NoteListTile(
                          note: e.$1,
                          source: e.$2,
                        ))
                    .toList(),
              );
            })
      ],
    );
  }
}
