import 'package:flow/cubits/flow.dart';
import 'package:flow/pages/groups/select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lib5/lib5.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/event/service.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/place/model.dart';

import '../../widgets/source_dropdown.dart';
import '../places/select.dart';
import 'select.dart';

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
    final descriptionController =
        TextEditingController(text: currentEvent.description);
    final locationController =
        TextEditingController(text: currentEvent.location);
    return AlertDialog(
      title: Text(create
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
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).name,
                  icon: const Icon(Icons.folder_outlined),
                  filled: true,
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
                                    : SourcedModel(
                                        source!, currentEvent.groupId!),
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
                                      .getService(source!)
                                      .group
                                      ?.getGroup(currentEvent.groupId!)),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!.name);
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return Text(AppLocalizations.of(context)
                                          .notSupported);
                                    }
                                  },
                                ),
                        )),
                const SizedBox(height: 16),
                StatefulBuilder(
                    builder: (context, setState) => ListTile(
                          leading: const Icon(Icons.location_on_outlined),
                          title: Text(AppLocalizations.of(context).place),
                          onTap: () async {
                            final sourcePlace =
                                await showDialog<SourcedModel<Place>>(
                              context: context,
                              builder: (context) => PlaceSelectDialog(
                                selected: currentEvent.placeId == null
                                    ? null
                                    : SourcedModel(
                                        source!, currentEvent.placeId!),
                                source: source!,
                              ),
                            );
                            if (sourcePlace != null) {
                              setState(() {
                                currentEvent = currentEvent.copyWith(
                                    placeId: sourcePlace.model.id);
                              });
                            }
                          },
                          subtitle: currentEvent.placeId == null
                              ? null
                              : FutureBuilder<Place?>(
                                  future: Future.value(context
                                      .read<FlowCubit>()
                                      .getService(source!)
                                      .place
                                      ?.getPlace(currentEvent.placeId!)),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!.name);
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return Text(AppLocalizations.of(context)
                                          .notSupported);
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
            final navigator = Navigator.of(context);
            if (create) {
              final created = await currentService?.createEvent(currentEvent);
              if (created != null) {
                currentEvent = created;
              }
            } else {
              currentService?.updateEvent(currentEvent);
            }
            navigator.pop(SourcedModel(currentSource, currentEvent));
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}

class EventListTile extends StatefulWidget {
  final String source;
  final Multihash? value;
  final ValueChanged<Multihash?> onChanged;

  const EventListTile({
    super.key,
    required this.source,
    this.value,
    required this.onChanged,
  });

  @override
  State<EventListTile> createState() => _EventListTileState();
}

class _EventListTileState extends State<EventListTile> {
  Multihash? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _onChanged(Multihash? value) {
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Event?>(
        future: Future.value(_value == null
            ? null
            : context
                .read<FlowCubit>()
                .getService(widget.source)
                .event
                ?.getEvent(_value!)),
        builder: (context, snapshot) {
          final event = snapshot.data;
          return ListTile(
            title: Text(AppLocalizations.of(context).event),
            subtitle: Text(event?.name ?? AppLocalizations.of(context).notSet),
            leading: Icon(event == null ? Icons.event : Icons.event_outlined),
            onTap: () async {
              if (event != null) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => EventDialog(
                    event: event,
                    source: widget.source,
                  ),
                );
              } else {
                final event = await showDialog<SourcedModel<Event>>(
                  context: context,
                  builder: (context) => EventSelectDialog(
                    source: widget.source,
                  ),
                );
                _onChanged(event?.model.id);
              }
            },
            trailing: _value == null
                ? IconButton(
                    icon: const Icon(Icons.add_circle_outline_outlined),
                    onPressed: () async {
                      final event = await showDialog<SourcedModel<Event>>(
                        context: context,
                        builder: (context) => EventDialog(
                          source: widget.source,
                        ),
                      );
                      _onChanged(event?.model.id);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _onChanged(null);
                    },
                  ),
          );
        });
  }
}
