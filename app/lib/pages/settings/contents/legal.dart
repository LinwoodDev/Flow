import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalSettingsView extends StatelessWidget {
  const LegalSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppLocalizations.of(context)!.legal,
            style: Theme.of(context).textTheme.headline5),
        const SizedBox(height: 32),
        ListTile(
          title: Text(AppLocalizations.of(context)!.license),
          leading: const Icon(Icons.description_outlined),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "flow/license")),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.privacyPolicy),
          leading: const Icon(Icons.privacy_tip_outlined),
          onTap: () =>
              launchUrl(Uri.https("docs.flow.linwood.dev", "privacypolicy")),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.imprint),
          leading: const Icon(Icons.info_outline),
          onTap: () => launchUrl(Uri.https("go.linwood.dev", "imprint")),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.thirdPartyLicenses),
          leading: const Icon(Icons.article_outlined),
          onTap: () => showLicensePage(context: context),
        ),
      ],
    );
  }
}
