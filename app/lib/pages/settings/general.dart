import 'dart:convert';

import 'package:flow/cubits/settings.dart';
import 'package:flow/main.dart';
import 'package:flow/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../intro/dialog.dart';

@immutable
class Meta {
  final String stableVersion, nightlyVersion, developVersion, mainVersion;

  const Meta({
    required this.stableVersion,
    required this.nightlyVersion,
    required this.developVersion,
    required this.mainVersion,
  });
  Meta.fromJson(Map<String, dynamic> json)
      : stableVersion = json['version']?['stable'] ?? '?',
        nightlyVersion = json['version']?['nightly'] ?? '?',
        developVersion = json['version']?['develop'] ?? '?',
        mainVersion = json['version']?['main'] ?? '?';
}

class GeneralSettingsPage extends StatefulWidget {
  final bool inView;

  const GeneralSettingsPage({super.key, this.inView = false});

  @override
  State<GeneralSettingsPage> createState() => _GeneralSettingsPageState();
}

class _GeneralSettingsPageState extends State<GeneralSettingsPage> {
  Future<Meta>? _metaFuture;
  final Future<String> _currentVersion = getCurrentVersion();

  void loadMeta() => setState(() {
        _metaFuture = _fetchMeta();
      });

  Future<Meta> _fetchMeta() async {
    final response = await http.get(
      Uri.parse('https://flow.linwood.dev/meta.json'),
    );
    return Meta.fromJson({...json.decode(response.body)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, FlowSettings>(
        title: Text(AppLocalizations.of(context).general),
        backgroundColor: widget.inView ? Colors.transparent : null,
        inView: widget.inView,
      ),
      body: ListView(
        children: [
          Card(
            margin: settingsCardMargin,
            child: FutureBuilder(
              future: _currentVersion,
              builder: (context, snapshot) {
                final currentVersion = snapshot.data ?? '?';
                return Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: settingsCardTitlePadding,
                        child: Text(
                          AppLocalizations.of(context).update,
                          style: TextTheme.of(context).headlineSmall,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).currentVersion,
                        ),
                        subtitle: Text(currentVersion),
                        onTap: () => saveToClipboard(context, currentVersion),
                      ),
                      if (!kIsWeb)
                        FutureBuilder<Meta>(
                          future: _metaFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!snapshot.hasData) {
                              return ListTile(
                                title: Text(
                                  AppLocalizations.of(context).checkForUpdates,
                                ),
                                subtitle: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).checkForUpdatesWarning,
                                ),
                                onTap: loadMeta,
                              );
                            }
                            final meta = snapshot.data!;
                            final stableVersion = meta.stableVersion;
                            final nightlyVersion = meta.nightlyVersion;
                            final developVersion = meta.developVersion;
                            final mainVersion = meta.mainVersion;
                            final isStable = currentVersion == stableVersion;
                            final isNightly = currentVersion == nightlyVersion;
                            final isDevelop = currentVersion == developVersion;
                            final isMain = currentVersion == mainVersion;
                            final isError = meta.nightlyVersion == '?' ||
                                meta.stableVersion == '?';
                            final isUpdateAvailable = !isError &&
                                !isStable &&
                                !isNightly &&
                                !isDevelop &&
                                !isMain;
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    AppLocalizations.of(context).stable,
                                  ),
                                  subtitle: Text(stableVersion),
                                  onTap: () => saveToClipboard(
                                    context,
                                    stableVersion,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    AppLocalizations.of(context).nightly,
                                  ),
                                  subtitle: Text(nightlyVersion),
                                  onTap: () => saveToClipboard(
                                    context,
                                    nightlyVersion,
                                  ),
                                ),
                                const Divider(),
                                if (isStable) ...[
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      ).usingLatestStable,
                                    ),
                                  ),
                                ] else if (isNightly ||
                                    isDevelop ||
                                    isMain) ...[
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      ).usingLatestNightly,
                                    ),
                                  ),
                                ] else if (isError) ...[
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(context).error,
                                    ),
                                  ),
                                ] else if (isUpdateAvailable)
                                  ListTile(
                                    title: Text(
                                      AppLocalizations.of(
                                        context,
                                      ).updateAvailable,
                                    ),
                                    subtitle: Text(
                                      AppLocalizations.of(context).updateNow,
                                    ),
                                    leading: const PhosphorIcon(
                                      PhosphorIconsLight.arrowRight,
                                    ),
                                    onTap: () async {
                                      await launchUrl(
                                        Uri.parse(
                                          'https://flow.linwood.dev/downloads',
                                        ),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                  ),
                              ],
                            );
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Card(
            margin: settingsCardMargin,
            child: Padding(
              padding: settingsCardPadding,
              child: Column(
                children: [
                  ListTile(
                    title: Text(AppLocalizations.of(context).documentation),
                    leading: const PhosphorIcon(PhosphorIconsLight.article),
                    onTap: () =>
                        launchUrl(Uri.https("docs.flow.linwood.dev", "")),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context).releaseNotes),
                    leading: const PhosphorIcon(PhosphorIconsLight.flag),
                    onTap: () => launchUrl(Uri.https(
                        "go.linwood.dev", "flow/$applicationMinorVersion")),
                  ),
                  ListTile(
                    title: const Text("Matrix"),
                    leading: const PhosphorIcon(PhosphorIconsLight.chat),
                    onTap: () =>
                        launchUrl(Uri.https("go.linwood.dev", "matrix")),
                  ),
                  ListTile(
                    title: const Text("Discord"),
                    leading: const PhosphorIcon(PhosphorIconsLight.chat),
                    onTap: () =>
                        launchUrl(Uri.https("go.linwood.dev", "discord")),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context).translate),
                    leading: const PhosphorIcon(PhosphorIconsLight.translate),
                    onTap: () => launchUrl(
                        Uri.https("go.linwood.dev", "flow/translate")),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context).source),
                    leading: const PhosphorIcon(PhosphorIconsLight.code),
                    onTap: () =>
                        launchUrl(Uri.https("go.linwood.dev", "flow/source")),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context).changelog),
                    leading: const PhosphorIcon(
                        PhosphorIconsLight.clockCounterClockwise),
                    onTap: () => launchUrl(
                        Uri.https("docs.flow.linwood.dev", "changelog")),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context).intro),
                    leading: const PhosphorIcon(PhosphorIconsLight.info),
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => const IntroDialog()),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: settingsCardMargin,
            child: Padding(
              padding: settingsCardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(AppLocalizations.of(context).license),
                    leading: const PhosphorIcon(PhosphorIconsLight.stack),
                    onTap: () =>
                        launchUrl(Uri.https("go.linwood.dev", "flow/license")),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context).imprint),
                    leading: const PhosphorIcon(PhosphorIconsLight.info),
                    onTap: () =>
                        launchUrl(Uri.https("go.linwood.dev", "imprint")),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context).privacyPolicy),
                    leading: const PhosphorIcon(PhosphorIconsLight.shield),
                    onTap: () => launchUrl(
                        Uri.https("docs.flow.linwood.dev", "privacypolicy")),
                  ),
                  ListTile(
                    title:
                        Text(AppLocalizations.of(context).thirdPartyLicenses),
                    leading: const PhosphorIcon(PhosphorIconsLight.file),
                    onTap: () => showLicensePage(context: context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
