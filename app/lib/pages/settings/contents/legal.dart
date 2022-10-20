import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LegalSettingsView extends StatelessWidget {
  const LegalSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppLocalizations.of(context)!.legal,
            style: Theme.of(context).textTheme.headline5),
        const SizedBox(height: 32),
        ListTile(
          title: Text(AppLocalizations.of(context)!.license),
          leading: const Icon(Icons.description_outlined),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.privacyPolicy),
          leading: const Icon(Icons.privacy_tip_outlined),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.imprint),
          leading: const Icon(Icons.info_outline),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.thirdPartyLicenses),
          leading: const Icon(Icons.article_outlined),
          onTap: () {},
        ),
      ],
    );
  }
}
