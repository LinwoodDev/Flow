import 'package:flow/api/storage/sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VersionSettingsView extends StatelessWidget {
  const VersionSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(AppLocalizations.of(context)!.version,
          style: Theme.of(context).textTheme.headline5),
      const SizedBox(height: 32),
      ListTile(
        leading: const Icon(Icons.storage_outlined),
        title: const Text('Database Version'),
        subtitle: FutureBuilder<String>(
            future: context.read<SourcesService>().local.getSqliteVersion(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data ?? 'Unknown');
              } else {
                return const Text('Loading...');
              }
            }),
      )
    ]);
  }
}
