import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsDrawer extends StatelessWidget {
  final List<GlobalKey> itemKeys;
  final int selected;
  final void Function(int) onChanged;

  const SettingsDrawer({
    super.key,
    required this.itemKeys,
    this.selected = -1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ...<List<dynamic>>[
        [Icons.refresh_outlined, AppLocalizations.of(context).version],
        [Icons.palette_outlined, AppLocalizations.of(context).personalization],
        [Icons.info_outlined, AppLocalizations.of(context).information],
        [Icons.article_outlined, AppLocalizations.of(context).legal]
      ].asMap().entries.map((e) => ListTile(
          title: Text(e.value[1]),
          leading: Icon(e.value[0]),
          selected: e.key == selected,
          onTap: () => onChanged(e.key))),
    ]);
  }
}
