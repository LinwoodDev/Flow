import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/sources/import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/converters/ical.dart';

import 'caldav.dart';
import 'ical.dart';

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
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).limited,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                ListTile(
                  title: const Text("CalDAV"),
                  subtitle:
                      Text(AppLocalizations.of(context).caldavDescription),
                  leading: const PhosphorIcon(PhosphorIconsLight.globe),
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => CalDavSourceDialog(),
                    );
                  },
                ),
                ListTile(
                  title: const Text("iCal"),
                  subtitle: Text(AppLocalizations.of(context).icalDescription),
                  leading: const PhosphorIcon(PhosphorIconsLight.calendar),
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => ICalSourceDialog(),
                    );
                  },
                ),
                const Divider(),
                Text(
                  AppLocalizations.of(context).comingSoon,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                ListTile(
                  title: const Text("WebDAV"),
                  subtitle:
                      Text(AppLocalizations.of(context).webdavDescription),
                  leading: const PhosphorIcon(PhosphorIconsLight.fileText),
                  enabled: false,
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => CalDavSourceDialog(),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Sia"),
                  enabled: false,
                  subtitle: Text(
                      AppLocalizations.of(context).decentralizedDescription),
                  leading: const PhosphorIcon(PhosphorIconsLight.cloud),
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => CalDavSourceDialog(),
                    );
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context).server),
                  subtitle:
                      Text(AppLocalizations.of(context).serverDescription),
                  leading: const PhosphorIcon(PhosphorIconsLight.hardDrive),
                  onTap: () => Navigator.of(context).pop(),
                  enabled: false,
                ),
                const Divider(),
                ListTile(
                    title: Text(AppLocalizations.of(context).importFile),
                    subtitle: Text(
                        AppLocalizations.of(context).importFileDescription),
                    leading: const PhosphorIcon(PhosphorIconsLight.file),
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
