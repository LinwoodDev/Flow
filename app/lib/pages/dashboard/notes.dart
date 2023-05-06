import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/note/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/markdown_field.dart';

class DashboardNotesCard extends StatefulWidget {
  const DashboardNotesCard({Key? key}) : super(key: key);

  @override
  State<DashboardNotesCard> createState() => _DashboardNotesCardState();
}

class _DashboardNotesCardState extends State<DashboardNotesCard> {
  Future<List<Note>> _getNotes(BuildContext context) async {
    final sources = context.read<FlowCubit>().getCurrentServices();
    final notes = <Note>[];
    for (final source in sources) {
      notes.addAll(await source.note?.getNotes() ?? []);
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
              icon: const PhosphorIcon(PhosphorIconsLight.arrowSquareOut),
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
                        subtitle: MarkdownText(e.description),
                        onTap: () =>
                            GoRouter.of(context).push('/notes/${e.id}').then(
                                  (value) => setState(() {}),
                                )))
                    .toList(),
              );
            })
      ],
    );
  }
}
