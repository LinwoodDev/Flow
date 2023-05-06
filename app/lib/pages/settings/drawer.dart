import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
        [
          PhosphorIconsLight.arrowClockwise,
          AppLocalizations.of(context).version
        ],
        [
          PhosphorIconsLight.palette,
          AppLocalizations.of(context).personalization
        ],
        [PhosphorIconsLight.info, AppLocalizations.of(context).information],
        [PhosphorIconsLight.article, AppLocalizations.of(context).legal]
      ].asMap().entries.map((e) => ListTile(
          title: Text(e.value[1]),
          leading: PhosphorIcon(e.value[0]),
          selected: e.key == selected,
          onTap: () => onChanged(e.key))),
    ]);
  }
}
