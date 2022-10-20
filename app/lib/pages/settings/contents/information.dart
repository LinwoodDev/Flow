import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InformationSettingsView extends StatelessWidget {
  const InformationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppLocalizations.of(context)!.information,
            style: Theme.of(context).textTheme.headline5),
        const SizedBox(height: 32),
        ListTile(
          title: Text(AppLocalizations.of(context)!.releaseNotes),
          leading: const Icon(Icons.flag_outlined),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Discord"),
          leading: const Icon(Icons.chat_outlined),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Matrix"),
          leading: const Icon(Icons.chat_outlined),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Crowdin"),
          leading: const Icon(Icons.translate_outlined),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.source),
          leading: const Icon(Icons.code_outlined),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.documentation),
          leading: const Icon(Icons.help_outline),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.changelog),
          leading: const Icon(Icons.history_outlined),
          onTap: () {},
        ),
      ],
    );
  }
}
