import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateGroupDialog extends StatelessWidget {
  const CreateGroupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(AppLocalizations.of(context)!.createGroup),
      content: SizedBox(
        width: 500,
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              labelText: AppLocalizations.of(context)!.name,
              icon: const Icon(Icons.folder_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.description,
              border: const OutlineInputBorder(),
              icon: const Icon(Icons.description_outlined),
            ),
            minLines: 3,
            maxLines: 5,
          )
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(AppLocalizations.of(context)!.create),
        )
      ],
    );
  }
}
