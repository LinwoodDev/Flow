import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/sources/import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/readers/ical.dart';
import 'package:simple_icons/simple_icons.dart';

import 'webdav.dart';

class AddSourceDialog extends StatelessWidget {
  const AddSourceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).addSource),
      content: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 500,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
                title: Text(AppLocalizations.of(context).caldav),
                subtitle: Text(AppLocalizations.of(context).caldavDescription),
                leading: const Icon(Icons.web_outlined),
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => CalDavSourceDialog(),
                  );
                }),
            ListTile(
                title: Text(AppLocalizations.of(context).server),
                subtitle: Text(AppLocalizations.of(context).serverDescription),
                leading: const Icon(Icons.storage_outlined),
                onTap: () => Navigator.of(context).pop()),
            ListTile(
                title: Text(AppLocalizations.of(context).decentralized),
                subtitle:
                    Text(AppLocalizations.of(context).decentralizedDescription),
                leading: const Icon(Icons.language_outlined),
                onTap: () => Navigator.of(context).pop()),
            const Divider(),
            ListTile(
                title: const Text("Google"),
                subtitle: Text(AppLocalizations.of(context).googleDescription),
                leading: const Icon(SimpleIcons.google),
                onTap: () => Navigator.of(context).pop()),
            ListTile(
                title: const Text("Microsoft"),
                subtitle:
                    Text(AppLocalizations.of(context).microsoftDescription),
                leading: const Icon(SimpleIcons.microsoft),
                onTap: () => Navigator.of(context).pop()),
            const Divider(),
            ListTile(
                title: Text(AppLocalizations.of(context).importFile),
                subtitle:
                    Text(AppLocalizations.of(context).importFileDescription),
                leading: const Icon(Icons.file_copy_outlined),
                onTap: () async {
                  final cubit = context.read<FlowCubit>();
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    withData: true,
                    allowedExtensions: ['ics', 'ical', 'icalendar'],
                  );
                  if (result == null) return;
                  final data = result.files.first.bytes;
                  if (data == null) return;
                  final lines = utf8.decode(data).split('\n');
                  final converter = ICalConverter();
                  converter.read(lines);
                  final events = converter.data?.events ?? [];
                  if (context.mounted) {
                    final success = await showDialog<bool>(
                      context: context,
                      builder: (context) => ImportDialog(events: events),
                    );
                    if (success != true) return;
                    final service = cubit.getCurrentService().event;
                    await Future.wait(events
                        .map((event) async => service?.createEvent(event)));
                  }
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }),
          ]),
        ),
      ),
      scrollable: true,
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).cancel))
      ],
    );
  }
}
