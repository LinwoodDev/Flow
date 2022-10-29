import 'package:flow/pages/settings/contents/information.dart';
import 'package:flow/pages/settings/contents/legal.dart';
import 'package:flow/pages/settings/contents/personalization.dart';
import 'package:flow/pages/settings/contents/version.dart';
import 'package:flutter/material.dart';

class SettingsContent extends StatelessWidget {
  final List<GlobalKey> itemKeys;
  const SettingsContent({super.key, required this.itemKeys});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...[
          const VersionSettingsView(),
          const PersonalizationSettingsView(),
          const InformationSettingsView(),
          const LegalSettingsView()
        ].asMap().entries.map((e) => Card(
            key: itemKeys[e.key],
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            child: Padding(padding: const EdgeInsets.all(32), child: e.value)))
      ],
    );
  }
}
