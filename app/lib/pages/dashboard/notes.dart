import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/models/note/model.dart';

import '../../cubits/flow.dart';

class DashboardNotesCard extends StatelessWidget {
  const DashboardNotesCard({Key? key}) : super(key: key);

  Future<List<Note>> _getNotes(BuildContext context) async {
    final sources = context.read<FlowCubit>().getCurrentServices();
    final notes = <Note>[];
    for (final source in sources) {
      notes.addAll(await source.note?.getNotes() ?? []);
    }
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              icon: const Icon(Icons.open_in_new_outlined),
              onPressed: () => GoRouter.of(context).go('/notes'),
            )
          ],
        ),
        const SizedBox(height: 20),
        FutureBuilder<List<Note>>(
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
                    .map((e) => ListTile(
                          title: Text(e.name),
                          subtitle: Text(e.description),
                        ))
                    .toList(),
              );
            })
      ],
    );
  }
}
