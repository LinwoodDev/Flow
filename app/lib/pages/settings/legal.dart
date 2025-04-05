import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';

class LegalSettingsView extends StatelessWidget {
  const LegalSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppLocalizations.of(context).legal,
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 32),
      ],
    );
  }
}
