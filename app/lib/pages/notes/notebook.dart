import 'package:flow/pages/groups/view.dart';
import 'package:flow/pages/users/view.dart';
import 'package:flow/widgets/markdown_field.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flow_api/models/note/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/source_dropdown.dart';

class NotebookDialog extends StatelessWidget {
  final String? source;
  final Notebook? notebook;
  final bool create;

  const NotebookDialog({
    super.key,
    this.source,
    this.notebook,
    this.create = false,
  });

  @override
  Widget build(BuildContext context) {
    final create = this.create || notebook == null || source == null;
    final cubit = context.read<FlowCubit>();
    var currentNotebook = notebook ?? const Notebook();
    var currentSource = source ?? '';
    final service = cubit.sourcesService.getSource(currentSource);
    var currentService = service.note;
    final userConnector = service.eventUser;
    final groupConnector = service.eventGroup;
    final tabs = !create && userConnector != null && groupConnector != null;
    return ResponsiveAlertDialog(
      title: Text(create
          ? AppLocalizations.of(context).createNotebook
          : AppLocalizations.of(context).editNotebook),
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
      content: DefaultTabController(
        length: tabs ? 3 : 1,
        child: Column(
          spacing: 8,
          children: [
            if (tabs)
              TabBar(
                  isScrollable: true,
                  tabs: [
                    (
                      PhosphorIconsLight.faders,
                      AppLocalizations.of(context).general
                    ),
                    (
                      PhosphorIconsLight.user,
                      AppLocalizations.of(context).users
                    ),
                    (
                      PhosphorIconsLight.usersThree,
                      AppLocalizations.of(context).group
                    ),
                  ]
                      .map((e) => HorizontalTab(
                            icon: PhosphorIcon(e.$1),
                            label: Text(e.$2),
                          ))
                      .toList()),
            Flexible(
              child: TabBarView(
                children: [
                  ListView(children: [
                    if (source == null) ...[
                      SourceDropdown<NoteService>(
                        value: currentSource,
                        buildService: (e) => e.note,
                        onChanged: (connected) {
                          currentSource = connected?.source ?? '';
                          currentService = connected?.model;
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).name,
                        filled: true,
                        icon: const PhosphorIcon(PhosphorIconsLight.fileText),
                      ),
                      initialValue: currentNotebook.name,
                      onChanged: (value) {
                        currentNotebook = currentNotebook.copyWith(name: value);
                      },
                    ),
                    const SizedBox(height: 16),
                    MarkdownField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).description,
                        border: const OutlineInputBorder(),
                        icon: const PhosphorIcon(PhosphorIconsLight.fileText),
                      ),
                      value: currentNotebook.description,
                      onChanged: (value) {
                        currentNotebook =
                            currentNotebook.copyWith(description: value);
                      },
                    )
                  ]),
                  if (tabs) ...[
                    UsersView(
                      model: currentNotebook,
                      connector: userConnector,
                      source: currentSource,
                    ),
                    GroupsView(
                      model: currentNotebook,
                      connector: groupConnector,
                      source: currentSource,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            if (create) {
              final created =
                  await currentService?.createNotebook(currentNotebook);
              if (created == null) {
                return;
              }
              currentNotebook = created;
            } else {
              await currentService?.updateNotebook(currentNotebook);
            }
            if (context.mounted) {
              Navigator.of(context)
                  .pop(SourcedModel(currentSource, currentNotebook));
            }
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
