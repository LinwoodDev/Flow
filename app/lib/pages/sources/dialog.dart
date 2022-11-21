import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddSourceDialog extends StatelessWidget {
  const AddSourceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addSource),
      content: SizedBox(
        width: 500,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
              title: Text(AppLocalizations.of(context)!.webdav),
              subtitle: Text(AppLocalizations.of(context)!.webdavDescription),
              leading: const Icon(Icons.web_outlined),
              onTap: () => Navigator.of(context).pop()),
          ListTile(
              title: Text(AppLocalizations.of(context)!.server),
              subtitle: Text(AppLocalizations.of(context)!.serverDescription),
              leading: const Icon(Icons.storage_outlined),
              onTap: () => Navigator.of(context).pop()),
          ListTile(
              title: Text(AppLocalizations.of(context)!.decentralized),
              subtitle:
                  Text(AppLocalizations.of(context)!.decentralizedDescription),
              leading: const Icon(Icons.language_outlined),
              onTap: () => Navigator.of(context).pop()),
        ]),
      ),
      scrollable: true,
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel))
      ],
    );
  }
}
