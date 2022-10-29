import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../intro/dialog.dart';

class InformationSettingsView extends StatelessWidget {
  const InformationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppLocalizations.of(context)!.information,
            style: Theme.of(context).textTheme.headline5),
        const SizedBox(height: 32),
        ListTile(
          title: Text(AppLocalizations.of(context)!.intro),
          leading: const Icon(Icons.info_outline),
          onTap: () => showDialog(
              context: context, builder: (context) => const IntroDialog()),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.releaseNotes),
          leading: const Icon(Icons.flag_outlined),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "flow/1.0")),
        ),
        ListTile(
          title: const Text("Discord"),
          leading: const Icon(Icons.chat_outlined),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "discord")),
        ),
        ListTile(
          title: const Text("Matrix"),
          leading: const Icon(Icons.chat_outlined),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "matrix")),
        ),
        ListTile(
          title: const Text("Crowdin"),
          leading: const Icon(Icons.translate_outlined),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "flow/crowdin")),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.source),
          leading: const Icon(Icons.code_outlined),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "flow/source")),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.documentation),
          leading: const Icon(Icons.help_outline),
          onTap: () => launchUrl(Uri.https("docs.flow.linwood.dev", "")),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.changelog),
          leading: const Icon(Icons.history_outlined),
          onTap: () =>
              launchUrl(Uri.https("docs.flow.linwood.dev", "changelog")),
        ),
      ],
    );
  }
}
