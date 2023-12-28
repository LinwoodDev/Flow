import 'package:flow/api/storage/sources.dart';
import 'package:flow/visualizer/sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
          leading: const PhosphorIcon(PhosphorIconsLight.cloud),
          title: Text(AppLocalizations.of(context).databaseVersion),
          subtitle: FutureBuilder<String>(
              future: context.read<SourcesService>().local.getSqliteVersion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      snapshot.data ?? AppLocalizations.of(context).unknown);
                } else {
                  return Text(AppLocalizations.of(context).loading);
                }
              }),
        ),
        ListTile(
          leading: const PhosphorIcon(PhosphorIconsLight.info),
          title: Text(AppLocalizations.of(context).version),
          subtitle: FutureBuilder<String>(
              future: PackageInfo.fromPlatform().then((value) => value.version),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      snapshot.data ?? AppLocalizations.of(context).unknown);
                } else {
                  return Text(AppLocalizations.of(context).loading);
                }
              }),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).syncMode),
          leading: PhosphorIcon(state.syncMode.icon(PhosphorIconsStyle.light)),
          subtitle: Text(state.syncMode.getLocalizedName(context)),
          onTap: () async => showLeapBottomSheet(
              title: AppLocalizations.of(context).syncMode,
              context: context,
              childrenBuilder: (ctx) {
                final settingsCubit = context.read<SettingsCubit>();
                void changeSyncMode(SyncMode syncMode) {
                  settingsCubit.changeSyncMode(syncMode);
                  Navigator.of(context).pop();
                }

                return SyncMode.values.map((syncMode) {
                  return ListTile(
                    title: Text(syncMode.getLocalizedName(context)),
                    leading:
                        PhosphorIcon(syncMode.icon(PhosphorIconsStyle.light)),
                    selected: syncMode == settingsCubit.state.syncMode,
                    onTap: () => changeSyncMode(syncMode),
                  );
                }).toList();
              }),
        ),
      ]),
    );
  }
}
