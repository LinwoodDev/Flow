import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/groups/select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flow_api/models/event/service.dart';
import 'package:flow_api/models/model.dart';

import '../../widgets/markdown_field.dart';
import '../../widgets/source_dropdown.dart';
import '../places/select.dart';

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
    var currentService = cubit.sourcesService.getSource(currentSource).event;
    final nameController = TextEditingController(text: currentEvent.name);
    final locationController =
        TextEditingController(text: currentEvent.location);
    return ResponsiveAlertDialog(
      title: Text(create
          ? AppLocalizations.of(context).createEvent
          : AppLocalizations.of(context).editEvent),
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
      content: ListView(
        shrinkWrap: true,
        children: [
          if (source == null) ...[
            SourceDropdown<EventService>(
              value: currentSource,
              buildService: (source) => source.event,
              onChanged: (connected) {
                currentSource = connected?.source ?? '';
                currentService = connected?.model;
                currentEvent = currentEvent.copyWith(
                  groupId: null,
                  placeId: null,
                );
              },
            ),
            const SizedBox(height: 16),
          ],
          const SizedBox(height: 16),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).name,
              icon: const PhosphorIcon(PhosphorIconsLight.fileText),
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
              icon: const PhosphorIcon(PhosphorIconsLight.fileText),
            ),
            value: currentEvent.description,
            onChanged: (value) =>
                currentEvent = currentEvent.copyWith(description: value),
          ),
          const SizedBox(height: 16),
          GroupSelectTile(
            source: currentSource,
            value: currentEvent.groupId,
            onChanged: (value) {
              currentEvent = currentEvent.copyWith(groupId: value?.model);
            },
          ),
          const SizedBox(height: 16),
          PlaceSelectTile(
            source: currentSource,
            value: currentEvent.placeId,
            onChanged: (value) {
              currentEvent = currentEvent.copyWith(placeId: value?.model);
            },
          ),
          const SizedBox(height: 8),
          StatefulBuilder(
              builder: (context, setState) => CheckboxListTile(
                    secondary: const Icon(PhosphorIconsLight.circleHalfTilt),
                    title: Text(AppLocalizations.of(context).blocked),
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
            onChanged: (value) =>
                currentEvent = currentEvent.copyWith(location: value),
          ),
        ],
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
