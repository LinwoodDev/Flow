import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flow/api/storage/sources.dart';
import 'package:flow/visualizer/sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/settings.dart';

import 'package:settings_leap/settings_leap.dart';

import 'home.dart';

final dataSettingsPage = SettingsLeapPage<FlowSettings>(
  displayName: (context) => AppLocalizations.of(context).data,
  icon: PhosphorIconsLight.database,
  appBarBuilder: flowSettingsAppBar,
  sections: {
    'database': SettingsLeapSection(
      settings: [
        SettingsLeapCustomSetting(
          id: 'databaseVersion',
          displayName: (context) =>
              AppLocalizations.of(context).databaseVersion,
          builder: (context, state) => ListTile(
            leading: const PhosphorIcon(PhosphorIconsLight.cloud),
            title: Text(AppLocalizations.of(context).databaseVersion),
            subtitle: FutureBuilder<String>(
              future: context.read<SourcesService>().local.getSqliteVersion(),
              builder: (context, snapshot) => Text(
                snapshot.hasData
                    ? snapshot.data ?? AppLocalizations.of(context).unknown
                    : AppLocalizations.of(context).loading,
              ),
            ),
          ),
        ),
        SettingsLeapEnumSetting<FlowSettings, SyncMode>(
          id: 'syncMode',
          displayName: (context) => AppLocalizations.of(context).syncMode,
          icon: PhosphorIconsLight.cloud,
          values: SyncMode.values,
          read: (state) => state.syncMode,
          write: (context, value) =>
              context.read<SettingsCubit>().changeSyncMode(value),
          valueLabel: (context, value) => value.getLocalizedName(context),
          valueLeadingBuilder: (context, value) =>
              PhosphorIcon(value.icon(PhosphorIconsStyle.light)),
        ),
      ],
    ),
    'backup': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          id: 'import',
          displayName: (context) =>
              AppLocalizations.of(context).restoreSettingsFromFile,
          icon: PhosphorIconsLight.arrowSquareIn,
          onTap: _importSettings,
        ),
        SettingsLeapActionSetting(
          id: 'export',
          displayName: (context) =>
              AppLocalizations.of(context).exportSettingsToFile,
          icon: PhosphorIconsLight.arrowSquareOut,
          onTap: _exportSettings,
        ),
      ],
    ),
  },
);
void _importSettings(BuildContext context) async {
  final settingsCubit = context.read<SettingsCubit>();
  final result = await FilePicker.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['json'],
  ).then((result) => result.firstOrNull);
  if (result == null) return;
  final data = await result.readAsBytes();
  settingsCubit.importSettings(utf8.decode(data));
}

void _exportSettings(BuildContext context) async {
  final settingsCubit = context.read<SettingsCubit>();
  final data = await settingsCubit.exportSettings();
  if (!context.mounted) return;
  await exportFile(
    bytes: utf8.encode(data),
    context: context,
    fileExtension: 'json',
    fileName: 'settings',
    label: AppLocalizations.of(context).exportSettingsToFile,
    mimeType: 'application/json',
    uniformTypeIdentifier: 'public.json',
  );
}
