import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/groups/view.dart';
import 'package:flow/pages/notes/view.dart';
import 'package:flow/pages/resources/view.dart';
import 'package:flow/pages/users/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/event/service.dart';
import 'package:flow_api/models/model.dart';

import '../../widgets/markdown_field.dart';
import '../../widgets/source_dropdown.dart';

class EventDialog extends StatelessWidget {
  final String? source;
  final Event? event;
  final bool create;

  const EventDialog({
    super.key,
    this.source,
    this.event,
    this.create = false,
  });

  @override
  Widget build(BuildContext context) {
    final create = this.create || event == null || source == null;
    final cubit = context.read<FlowCubit>();
    var currentEvent = event ?? const Event();
    var currentSource = source ?? '';
    final service = cubit.sourcesService.getSource(currentSource);
    var currentService = service.event;
    final noteConnector = service.eventNote;
    final resourceConnector = service.eventResource;
    final userConnector = service.eventUser;
    final groupConnector = service.eventGroup;
    final nameController = TextEditingController(text: currentEvent.name);
    final locationController =
        TextEditingController(text: currentEvent.location);
    final tabs = !create &&
        noteConnector != null &&
        resourceConnector != null &&
        userConnector != null &&
        groupConnector != null;
    return ResponsiveAlertDialog(
      title: Text(create
          ? AppLocalizations.of(context).createEvent
          : AppLocalizations.of(context).editEvent),
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
      content: DefaultTabController(
        length: tabs ? 5 : 1,
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
                      PhosphorIconsLight.checkCircle,
                      AppLocalizations.of(context).notes
                    ),
                    (
                      PhosphorIconsLight.cube,
                      AppLocalizations.of(context).resources
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
                  Material(
                    color: Colors.transparent,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        if (source == null) ...[
                          SourceDropdown<EventService>(
                            value: currentSource,
                            buildService: (source) => source.event,
                            onChanged: (connected) {
                              currentSource = connected?.source ?? '';
                              currentService = connected?.model;
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).name,
                            icon:
                                const PhosphorIcon(PhosphorIconsLight.fileText),
                            filled: true,
                          ),
                          onChanged: (value) =>
                              currentEvent = currentEvent.copyWith(name: value),
                        ),
                        const SizedBox(height: 16),
                        MarkdownField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).description,
                            border: const OutlineInputBorder(),
                            icon:
                                const PhosphorIcon(PhosphorIconsLight.fileText),
                          ),
                          value: currentEvent.description,
                          onChanged: (value) => currentEvent =
                              currentEvent.copyWith(description: value),
                        ),
                        const SizedBox(height: 8),
                        StatefulBuilder(
                            builder: (context, setState) => CheckboxListTile(
                                  secondary: const Icon(
                                      PhosphorIconsLight.circleHalfTilt),
                                  title: Text(
                                      AppLocalizations.of(context).blocked),
                                  value: currentEvent.blocked,
                                  onChanged: (value) => setState(
                                    () => currentEvent = currentEvent.copyWith(
                                        blocked: value ?? currentEvent.blocked),
                                  ),
                                )),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).location,
                            icon: const PhosphorIcon(PhosphorIconsLight.mapPin),
                          ),
                          minLines: 1,
                          maxLines: 2,
                          controller: locationController,
                          onChanged: (value) => currentEvent =
                              currentEvent.copyWith(location: value),
                        ),
                      ],
                    ),
                  ),
                  if (tabs) ...[
                    NotesView(
                      model: currentEvent,
                      connector: noteConnector,
                      source: currentSource,
                    ),
                    ResourcesView(
                      model: currentEvent,
                      connector: resourceConnector,
                      source: currentSource,
                    ),
                    UsersView(
                      model: currentEvent,
                      connector: userConnector,
                      source: currentSource,
                    ),
                    GroupsView(
                      model: currentEvent,
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
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            if (create) {
              final created = await currentService?.createEvent(currentEvent);
              if (created == null) {
                return;
              }
              currentEvent = created;
            } else {
              await currentService?.updateEvent(currentEvent);
            }
            if (context.mounted) {
              Navigator.of(context)
                  .pop(SourcedModel(currentSource, currentEvent));
            }
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
