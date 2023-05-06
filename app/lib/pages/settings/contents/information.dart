import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../intro/dialog.dart';

class InformationSettingsView extends StatelessWidget {
  const InformationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppLocalizations.of(context).information,
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 32),
        ListTile(
          title: Text(AppLocalizations.of(context).intro),
          leading: const PhosphorIcon(PhosphorIconsLight.info),
          onTap: () => showDialog(
              context: context, builder: (context) => const IntroDialog()),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).releaseNotes),
          leading: const PhosphorIcon(PhosphorIconsLight.flag),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "flow/0.1")),
        ),
        ListTile(
          title: const Text("Discord"),
          leading: const PhosphorIcon(PhosphorIconsLight.chat),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "discord")),
        ),
        ListTile(
          title: const Text("Matrix"),
          leading: const PhosphorIcon(PhosphorIconsLight.chat),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "matrix")),
        ),
        ListTile(
          title: const Text("Crowdin"),
          leading: const PhosphorIcon(PhosphorIconsLight.translate),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "flow/crowdin")),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).source),
          leading: const PhosphorIcon(PhosphorIconsLight.code),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "flow/source")),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).documentation),
          leading: const PhosphorIcon(PhosphorIconsLight.article),
          onTap: () => launchUrl(Uri.https("docs.flow.linwood.dev", "")),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).changelog),
          leading: const PhosphorIcon(PhosphorIconsLight.clockCounterClockwise),
          onTap: () =>
              launchUrl(Uri.https("docs.flow.linwood.dev", "changelog")),
        ),
      ],
    );
  }
}
