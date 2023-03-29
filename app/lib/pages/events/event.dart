import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/groups/select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/model.dart';

import '../../widgets/source_dropdown.dart';

class EventDialog extends StatelessWidget {
  final String? source;
  final Event? event;

  const EventDialog({
    super.key,
    this.source,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    var currentEvent = event ?? const Event();
    var currentSource = source ?? '';
    final nameController = TextEditingController(text: currentEvent.name);
    final descriptionController =
        TextEditingController(text: currentEvent.description);
    final locationController =
        TextEditingController(text: currentEvent.location);
    return AlertDialog(
      title: Text(source == null
          ? AppLocalizations.of(context).createEvent
          : AppLocalizations.of(context).editEvent),
      content: SizedBox(
        width: 500,
        height: 500,
        child: Material(
          color: Colors.transparent,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 16),
              if (source == null) ...[
                SourceDropdown(
                  value: currentSource,
                  onChanged: (String? value) {
                    currentSource = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).name,
                  icon: const Icon(Icons.folder_outlined),
                ),
                onChanged: (value) =>
                    currentEvent = currentEvent.copyWith(name: value),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).description,
                  border: const OutlineInputBorder(),
                  icon: const Icon(Icons.description_outlined),
                ),
                minLines: 3,
                maxLines: 5,
                controller: descriptionController,
                onChanged: (value) =>
                    currentEvent = currentEvent.copyWith(description: value),
              ),
              if (source != null) ...[
                const SizedBox(height: 16),
                StatefulBuilder(
                    builder: (context, setState) => ListTile(
                          leading: const Icon(Icons.folder_outlined),
                          title: Text(AppLocalizations.of(context).group),
                          onTap: () async {
                            final sourceGroup =
                                await showDialog<SourcedModel<Group>>(
                              context: context,
                              builder: (context) => GroupSelectDialog(
                                selected: currentEvent.groupId == null
                                    ? null
                                    : MapEntry(source!, currentEvent.groupId!),
                                source: source!,
                              ),
                            );
                            if (sourceGroup != null) {
                              setState(() {
                                currentEvent = currentEvent.copyWith(
                                    groupId: sourceGroup.model.id);
                              });
                            }
                          },
                          subtitle: currentEvent.groupId == null
                              ? null
                              : FutureBuilder<Group?>(
                                  future: Future.value(context
                                      .read<FlowCubit>()
                                      .getSource(source!)
                                      .group
                                      ?.getGroup(currentEvent.groupId ?? -1)),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!.name);
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                        )),
              ],
              const SizedBox(height: 8),
              StatefulBuilder(
                  builder: (context, setState) => CheckboxListTile(
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
                  filled: true,
                  icon: const Icon(Icons.location_on_outlined),
                ),
                minLines: 1,
                maxLines: 2,
                controller: locationController,
                onChanged: (value) =>
                    currentEvent = currentEvent.copyWith(location: value),
              ),
            ],
          ),
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
            if (source == null) {
              final created = await context
                  .read<FlowCubit>()
                  .getSource(currentSource)
                  .event
                  ?.createEvent(currentEvent);
              if (created != null) {
                currentEvent = created;
              }
            } else {
              context
                  .read<FlowCubit>()
                  .getSource(source!)
                  .event
                  ?.updateEvent(currentEvent);
            }
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(currentEvent);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
