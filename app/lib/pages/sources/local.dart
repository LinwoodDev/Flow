import 'package:flow/api/storage/db/database.dart';
import 'package:flow/api/storage/file/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/storage/sources.dart';

class LocalSourceDialog extends StatelessWidget {
  const LocalSourceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(AppLocalizations.of(context).local),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
            title: Text(AppLocalizations.of(context).export),
            leading: const PhosphorIcon(PhosphorIconsLight.download),
            onTap: () async {
              Navigator.of(context).pop();
              final db = context.read<SourcesService>().local.db;
              final data = await exportDatabase(db);
              saveFile('flow.db', data);
            }),
        const Divider(),
        ListTile(
          leading: const PhosphorIcon(PhosphorIconsLight.cloud),
          title: Text(AppLocalizations.of(context).version),
          subtitle: FutureBuilder<String>(
              future: context.read<SourcesService>().local.getSqliteVersion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      snapshot.data ?? AppLocalizations.of(context).unknown);
                } else {
                  return Text(AppLocalizations.of(context).loading);
                }
              }),
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).close))
      ],
    );
  }
}
