import 'dart:convert';

import 'package:flow/cubits/settings.dart';
import 'package:flow/main.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:settings_leap/settings_leap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../intro/dialog.dart';
import 'home.dart';

final generalSettingsPage = SettingsLeapPage<FlowSettings>(
  displayName: (context) => AppLocalizations.of(context).general,
  icon: PhosphorIconsLight.gear,
  appBarBuilder: flowSettingsAppBar,
  sections: {
    'update': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).update,
      settings: [
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).currentVersion,
          builder: _currentVersionSetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) =>
              AppLocalizations.of(context).checkForUpdates,
          enabled: (context, state) => !kIsWeb,
          builder: (context, state) => const _UpdateCheckSetting(),
        ),
      ],
    ),
    'community': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).documentation,
          icon: PhosphorIconsLight.article,
          onTap: (context) => _openUrl(Uri.https('docs.flow.linwood.dev', '')),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).releaseNotes,
          icon: PhosphorIconsLight.flag,
          onTap: (context) => _openUrl(
            Uri.https('go.linwood.dev', 'flow/$applicationMinorVersion'),
          ),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => 'Matrix',
          icon: PhosphorIconsLight.users,
          onTap: (context) => _openUrl(Uri.https('go.linwood.dev', 'matrix')),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => 'Discord',
          icon: PhosphorIconsLight.users,
          onTap: (context) => _openUrl(Uri.https('go.linwood.dev', 'discord')),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).translate,
          icon: PhosphorIconsLight.translate,
          onTap: (context) =>
              _openUrl(Uri.https('go.linwood.dev', 'flow/translate')),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).source,
          icon: PhosphorIconsLight.code,
          onTap: (context) =>
              _openUrl(Uri.https('go.linwood.dev', 'flow/source')),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).changelog,
          icon: PhosphorIconsLight.arrowCounterClockwise,
          onTap: (context) =>
              _openUrl(Uri.https('docs.flow.linwood.dev', 'changelog')),
        ),
      ],
    ),
    'intro': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          id: 'intro',
          displayName: (context) => AppLocalizations.of(context).intro,
          icon: PhosphorIconsLight.info,
          onTap: (context) => showDialog(
            context: context,
            builder: (context) => const IntroDialog(),
          ),
        ),
      ],
    ),
    'legal': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).license,
          icon: PhosphorIconsLight.stack,
          onTap: (context) =>
              _openUrl(Uri.https('go.linwood.dev', 'flow/license')),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).imprint,
          icon: PhosphorIconsLight.identificationCard,
          onTap: (context) => _openUrl(Uri.https('go.linwood.dev', 'imprint')),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).privacyPolicy,
          icon: PhosphorIconsLight.shield,
          onTap: (context) =>
              _openUrl(Uri.https('docs.flow.linwood.dev', 'privacypolicy')),
        ),
        SettingsLeapActionSetting(
          displayName: (context) =>
              AppLocalizations.of(context).thirdPartyLicenses,
          icon: PhosphorIconsLight.file,
          onTap: (context) => showLicensePage(context: context),
        ),
      ],
    ),
  },
);

class _Meta {
  const _Meta({
    required this.stableVersion,
    required this.nightlyVersion,
    required this.developVersion,
    required this.mainVersion,
  });

  _Meta.fromJson(Map<String, dynamic> json)
    : stableVersion = json['version']?['stable'] ?? '?',
      nightlyVersion = json['version']?['nightly'] ?? '?',
      developVersion = json['version']?['develop'] ?? '?',
      mainVersion = json['version']?['main'] ?? '?';

  final String stableVersion;
  final String nightlyVersion;
  final String developVersion;
  final String mainVersion;
}

Widget _currentVersionSetting(BuildContext context, FlowSettings state) {
  return FutureBuilder<String>(
    future: getCurrentVersion(),
    builder: (context, snapshot) {
      final currentVersion = snapshot.data ?? '?';
      final currentVersionName = currentVersion;
      return ListTile(
        title: Text(AppLocalizations.of(context).currentVersion),
        subtitle: Text(currentVersionName),
        onTap: () => saveToClipboard(context, currentVersion),
      );
    },
  );
}

class _UpdateCheckSetting extends StatefulWidget {
  const _UpdateCheckSetting();

  @override
  State<_UpdateCheckSetting> createState() => _UpdateCheckSettingState();
}

class _UpdateCheckSettingState extends State<_UpdateCheckSetting> {
  Future<_Meta>? _metaFuture;
  final Future<String> _currentVersion = getCurrentVersion();

  void _loadMeta() {
    setState(() {
      _metaFuture = _fetchMeta();
    });
  }

  Future<_Meta> _fetchMeta() async {
    final response = await http.get(
      Uri.parse('https://flow.linwood.dev/meta.json'),
    );
    return _Meta.fromJson({...json.decode(response.body)});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _currentVersion,
      builder: (context, snapshot) {
        final currentVersion = snapshot.data ?? '?';
        return FutureBuilder<_Meta>(
          future: _metaFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ListTile(
                title: Text(AppLocalizations.of(context).error),
                subtitle: Text('${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return ListTile(
                title: Text(AppLocalizations.of(context).checkForUpdates),
                subtitle: Text(
                  AppLocalizations.of(context).checkForUpdatesWarning,
                ),
                onTap: _loadMeta,
              );
            }

            final meta = snapshot.data!;
            final stableVersion = meta.stableVersion;
            final nightlyVersion = meta.nightlyVersion;
            final isStable = currentVersion == stableVersion;
            final isNightly = currentVersion == nightlyVersion;
            final isDevelop = currentVersion == meta.developVersion;
            final isMain = currentVersion == meta.mainVersion;
            final isError =
                meta.nightlyVersion == '?' || meta.stableVersion == '?';
            final isUpdateAvailable =
                !isError && !isStable && !isNightly && !isDevelop && !isMain;

            return Column(
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).stable),
                  subtitle: Text(stableVersion),
                  onTap: () => saveToClipboard(context, stableVersion),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).nightly),
                  subtitle: Text(nightlyVersion),
                  onTap: () => saveToClipboard(context, nightlyVersion),
                ),
                const Divider(),
                if (isStable)
                  ListTile(
                    title: Text(AppLocalizations.of(context).usingLatestStable),
                  )
                else if (isNightly || isDevelop || isMain)
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context).usingLatestNightly,
                    ),
                  )
                else if (isError)
                  ListTile(title: Text(AppLocalizations.of(context).error))
                else if (isUpdateAvailable)
                  ListTile(
                    title: Text(AppLocalizations.of(context).updateAvailable),
                    subtitle: Text(AppLocalizations.of(context).updateNow),
                    leading: const PhosphorIcon(PhosphorIconsLight.arrowRight),
                    onTap: () => _openUrl(
                      Uri.parse('https://flow.linwood.dev/downloads'),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

Future<void> _openUrl(Uri uri) =>
    launchUrl(uri, mode: LaunchMode.externalApplication);
