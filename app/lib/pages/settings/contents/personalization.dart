import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonalizationSettingsView extends StatelessWidget {
  const PersonalizationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppLocalizations.of(context)!.personalization,
            style: Theme.of(context).textTheme.headline5),
        const SizedBox(height: 32),
        ListTile(
          title: Text(AppLocalizations.of(context)!.design),
          leading: const Icon(Icons.palette_outlined),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.theme),
          leading: const Icon(Icons.brightness_4_outlined),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.language),
          leading: const Icon(Icons.translate_outlined),
          onTap: () {},
        ),
      ],
    );
  }
}
