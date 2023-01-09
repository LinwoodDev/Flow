import 'package:flow/pages/sources/dialog.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'local.dart';

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).sources,
      body: SingleChildScrollView(
        child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(children: [
                ListTile(
                  title: Text(AppLocalizations.of(context).local),
                  leading: const Icon(Icons.computer_outlined),
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => const LocalSourceDialog()),
                )
              ]),
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
            context: context, builder: (context) => const AddSourceDialog()),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}
