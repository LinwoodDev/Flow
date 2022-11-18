import 'package:flow/pages/settings/content.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'drawer.dart';

class SettingsPage extends StatelessWidget {
  final List<GlobalKey> _itemKeys = List.generate(4, (index) => GlobalKey());
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context)!.settings,
      endDrawer: SettingsDrawer(
        itemKeys: _itemKeys,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SettingsContent(itemKeys: _itemKeys),
          ),
        ),
      ),
    );
  }
}
