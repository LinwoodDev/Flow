import 'package:flow/pages/settings/contents/information.dart';
import 'package:flow/pages/settings/contents/legal.dart';
import 'package:flow/pages/settings/contents/personalization.dart';
import 'package:flow/pages/settings/contents/data.dart';
import 'package:flutter/material.dart';

class SettingsContent extends StatelessWidget {
  final List<GlobalKey> itemKeys;
  const SettingsContent({super.key, required this.itemKeys});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...[
          const DataSettingsView(),
          const PersonalizationSettingsView(),
          const InformationSettingsView(),
          const LegalSettingsView()
        ].asMap().entries.map((e) => Container(
              key: itemKeys[e.key],
              child: Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
                  child: Padding(
                      padding: const EdgeInsets.all(32), child: e.value)),
            )),
      ],
    );
  }
}
