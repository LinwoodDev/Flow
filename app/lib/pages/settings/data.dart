import 'package:flow/api/storage/sources.dart';
import 'package:flow/theme.dart';
import 'package:flow/visualizer/sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/settings.dart';

class DataSettingsPage extends StatelessWidget {
  final bool inView;
  const DataSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, FlowSettings>(
        inView: inView,
        backgroundColor: inView ? Colors.transparent : null,
        title: Text(AppLocalizations.of(context).data),
      ),
      body: BlocBuilder<SettingsCubit, FlowSettings>(
        builder: (context, state) => ListView(
          children: [
            Card(
              margin: settingsCardMargin,
              child: Padding(
                padding: settingsCardPadding,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.cloud),
                        title:
                            Text(AppLocalizations.of(context).databaseVersion),
                        subtitle: FutureBuilder<String>(
                            future: context
                                .read<SourcesService>()
                                .local
                                .getSqliteVersion(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data ??
                                    AppLocalizations.of(context).unknown);
                              } else {
                                return Text(
                                    AppLocalizations.of(context).loading);
                              }
                            }),
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context).syncMode),
                        leading: PhosphorIcon(
                            state.syncMode.icon(PhosphorIconsStyle.light)),
                        subtitle:
                            Text(state.syncMode.getLocalizedName(context)),
                        onTap: () async => showLeapBottomSheet(
                            titleBuilder: (ctx) =>
                                Text(AppLocalizations.of(context).syncMode),
                            context: context,
                            childrenBuilder: (ctx) {
                              final settingsCubit =
                                  context.read<SettingsCubit>();
                              void changeSyncMode(SyncMode syncMode) {
                                settingsCubit.changeSyncMode(syncMode);
                                Navigator.of(context).pop();
                              }

                              return SyncMode.values.map((syncMode) {
                                return ListTile(
                                  title:
                                      Text(syncMode.getLocalizedName(context)),
                                  leading: PhosphorIcon(
                                      syncMode.icon(PhosphorIconsStyle.light)),
                                  selected:
                                      syncMode == settingsCubit.state.syncMode,
                                  onTap: () => changeSyncMode(syncMode),
                                );
                              }).toList();
                            }),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
