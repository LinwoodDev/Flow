import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsDrawer extends StatelessWidget {
  final List<GlobalKey> itemKeys;
  const SettingsDrawer({super.key, required this.itemKeys});

  @override
  Widget build(BuildContext context) {
    VoidCallback scroll(int number) => () => Scrollable.ensureVisible(
          itemKeys[number].currentContext!,
          duration: const Duration(milliseconds: 500),
        );
    return ListView(children: [
      ...<List<dynamic>>[
        [Icons.refresh_outlined, AppLocalizations.of(context)!.version],
        [Icons.palette_outlined, AppLocalizations.of(context)!.personalization],
        [Icons.info_outlined, AppLocalizations.of(context)!.information],
        [Icons.article_outlined, AppLocalizations.of(context)!.legal]
      ].asMap().entries.map((e) => ListTile(
          title: Text(e.value[1]),
          leading: Icon(e.value[0]),
          onTap: scroll(e.key))),
    ]);
  }
}
