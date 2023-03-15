import 'package:flow/api/storage/sources.dart';
import 'package:flow/visualizer/sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../cubits/settings.dart';

class DataSettingsView extends StatelessWidget {
  const DataSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, FlowSettings>(
      builder: (context, state) => Column(children: [
        Text(AppLocalizations.of(context).data,
            style: Theme.of(context).textTheme.headlineSmall),
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
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).syncMode),
          leading: Icon(state.syncMode.getIcon()),
          subtitle: Text(state.syncMode.getLocalizedName(context)),
          onTap: () async => showModalBottomSheet(
              constraints: const BoxConstraints(maxWidth: 640),
              context: context,
              builder: (ctx) {
                final settingsCubit = context.read<SettingsCubit>();
                void changeSyncMode(SyncMode syncMode) {
                  settingsCubit.setSyncMode(syncMode);
                  Navigator.of(context).pop();
                }

                return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ListView(shrinkWrap: true, children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Text(
                          AppLocalizations.of(context).syncMode,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ...SyncMode.values.map((syncMode) {
                        return ListTile(
                          title: Text(syncMode.getLocalizedName(context)),
                          leading: Icon(syncMode.getIcon()),
                          selected: syncMode == settingsCubit.state.syncMode,
                          onTap: () => changeSyncMode(syncMode),
                        );
                      }),
                      const SizedBox(height: 32),
                    ]));
              }),
        ),
      ]),
    );
  }
}
