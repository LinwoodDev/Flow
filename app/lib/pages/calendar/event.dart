import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/event.dart';
import 'package:flow/pages/groups/select.dart';
import 'package:flow/widgets/indicators/empty.dart';
import 'package:flow/widgets/indicators/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/note/model.dart';
import 'package:shared/models/note/service.dart';

import '../../widgets/date_time_field.dart';
import '../notes/note.dart';

class EventDialog extends StatelessWidget {
  final String? source;
  final Appointment? appointment;

  const EventDialog({super.key, this.appointment, this.source});

  @override
  Widget build(BuildContext context) {
    var currentAppointment = appointment ?? const Appointment.fixed();
    var currentSource = source ?? '';
    final nameController = TextEditingController(text: currentAppointment.name);
    final descriptionController =
        TextEditingController(text: currentAppointment.description);
    final locationController =
        TextEditingController(text: currentAppointment.location);
    return AlertDialog(
      title: Text(source == null
          ? AppLocalizations.of(context).createEvent
          : AppLocalizations.of(context).editEvent),
      content: SizedBox(
        width: 500,
        height: 500,
        child: DefaultTabController(
          length: source == null ? 1 : 2,
          child: Column(
            children: [
              if (source != null)
                TabBar(
                    tabs: <dynamic>[
                  [Icons.tune_outlined, AppLocalizations.of(context).general],
                  [
                    Icons.check_circle_outline_outlined,
                    AppLocalizations.of(context).notes
                  ],
                ]
                        .map((e) => Tab(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Icon(e[0]),
                                  const SizedBox(width: 8),
                                  Text(e[1]),
                                ])))
                        .toList()),
              Flexible(
                child: TabBarView(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: 16),
                          if (source == null) ...[
                            DropdownButtonFormField<String>(
                              value: source,
                              items: context
                                  .read<FlowCubit>()
                                  .getCurrentSources()
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value.isEmpty
                                      ? AppLocalizations.of(context).local
                                      : value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                currentSource = value ?? '';
                              },
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context).source,
                                icon: const Icon(Icons.storage_outlined),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          DropdownButtonFormField<EventStatus>(
                            value: currentAppointment.status,
                            items: EventStatus.values
                                .map<DropdownMenuItem<EventStatus>>((value) {
                              return DropdownMenuItem<EventStatus>(
                                value: value,
                                child: Row(
                                  children: [
                                    Icon(value.getIcon(),
                                        color: value.getColor()),
                                    const SizedBox(width: 8),
                                    Text(value.getLocalizedName(context)),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (EventStatus? value) {
                              currentAppointment = currentAppointment.copyWith(
                                  status: value ?? currentAppointment.status);
                            },
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).status,
                              icon: const Icon(Icons.info_outlined),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).name,
                              icon: const Icon(Icons.folder_outlined),
                            ),
                            onChanged: (value) => currentAppointment =
                                currentAppointment.copyWith(name: value),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context).description,
                              border: const OutlineInputBorder(),
                              icon: const Icon(Icons.description_outlined),
                            ),
                            minLines: 3,
                            maxLines: 5,
                            controller: descriptionController,
                            onChanged: (value) => currentAppointment =
                                currentAppointment.copyWith(description: value),
                          ),
                          if (source != null) ...[
                            const SizedBox(height: 16),
                            StatefulBuilder(
                                builder: (context, setState) => ListTile(
                                      leading:
                                          const Icon(Icons.folder_outlined),
                                      title: Text(
                                          AppLocalizations.of(context).group),
                                      onTap: () async {
                                        final groupId = await showDialog<
                                            MapEntry<String, int>>(
                                          context: context,
                                          builder: (context) =>
                                              GroupSelectDialog(
                                            selected:
                                                currentAppointment.groupId ==
                                                        null
                                                    ? null
                                                    : MapEntry(
                                                        source!,
                                                        currentAppointment
                                                            .groupId!),
                                            source: source!,
                                          ),
                                        );
                                        if (groupId != null) {
                                          setState(() {
                                            currentAppointment =
                                                currentAppointment.copyWith(
                                                    groupId: groupId.value);
                                          });
                                        }
                                      },
                                      subtitle: currentAppointment.groupId ==
                                              null
                                          ? null
                                          : FutureBuilder<Group?>(
                                              future: Future.value(context
                                                  .read<FlowCubit>()
                                                  .getSource(source!)
                                                  .group
                                                  ?.getGroup(currentAppointment
                                                          .groupId ??
                                                      -1)),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                      snapshot.data!.name);
                                                } else if (snapshot.hasError) {
                                                  return Text(snapshot.error
                                                      .toString());
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
                                    title: Text(
                                        AppLocalizations.of(context).blocked),
                                    value: currentAppointment.blocked,
                                    onChanged: (value) => setState(
                                      () => currentAppointment =
                                          currentAppointment.copyWith(
                                              blocked: value ??
                                                  currentAppointment.blocked),
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
                            onChanged: (value) => currentAppointment =
                                currentAppointment.copyWith(location: value),
                          ),
                          const SizedBox(height: 16),
                          DateTimeField(
                            label: AppLocalizations.of(context).start,
                            initialValue: currentAppointment.time.start,
                            icon: const Icon(Icons.calendar_today_outlined),
                            onChanged: (value) {
                              currentAppointment = currentAppointment.copyWith
                                  .time(start: value);
                            },
                            canBeEmpty: true,
                          ),
                          const SizedBox(height: 8),
                          DateTimeField(
                            label: AppLocalizations.of(context).end,
                            initialValue: currentAppointment.time.end,
                            icon: const Icon(Icons.calendar_today_outlined),
                            onChanged: (value) {
                              currentAppointment =
                                  currentAppointment.copyWith.time(end: value);
                            },
                            canBeEmpty: true,
                          ),
                        ],
                      ),
                    ),
                    if (source != null)
                      _EventNotesTab(
                          event: currentAppointment, source: source!),
                  ],
                ),
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
                  ?.createEvent(currentAppointment);
              if (created != null) {
                currentAppointment = created;
              }
            } else {
              context
                  .read<FlowCubit>()
                  .getSource(source!)
                  .event
                  ?.updateEvent(currentAppointment);
            }
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(currentAppointment);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}

class _EventNotesTab extends StatefulWidget {
  final Event event;
  final String source;
  const _EventNotesTab({required this.event, required this.source});

  @override
  State<_EventNotesTab> createState() => _EventNotesTabState();
}

class _EventNotesTabState extends State<_EventNotesTab> {
  static const _pageSize = 20;

  late final NoteService? _noteService;

  final PagingController<int, Note> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _noteService = context.read<FlowCubit>().getSource(widget.source).note;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _noteService?.getNotes(
          eventId: widget.event.id,
          offset: pageKey * _pageSize,
          limit: _pageSize);
      if (newItems == null) return;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      Stack(
        children: [
          Column(
            children: [
              Flexible(
                child: PagedListView<int, Note>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Note>(
                    noItemsFoundIndicatorBuilder: (context) =>
                        const EmptyIndicatorDisplay(),
                    firstPageErrorIndicatorBuilder: (context) =>
                        ErrorIndicatorDisplay(
                      onTryAgain: _pagingController.refresh,
                    ),
                    itemBuilder: (context, item, index) {
                      var status = item.status;
                      return Dismissible(
                        key: ValueKey(item.id),
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          _noteService?.deleteNote(item.id);
                          _pagingController.itemList!.remove(item);
                        },
                        child: ListTile(
                          title: Text(item.name),
                          leading: status == null
                              ? null
                              : StatefulBuilder(
                                  builder: (context, setState) => Checkbox(
                                    value: status?.done,
                                    tristate: true,
                                    onChanged: (_) async {
                                      bool? newState;
                                      if (status?.done == null) {
                                        newState = true;
                                      } else if (status?.done == true) {
                                        newState = false;
                                      } else {
                                        newState = null;
                                      }
                                      final next = NoteStatusExtension.fromDone(
                                          newState);
                                      _noteService?.updateNote(
                                          item.copyWith(status: next));
                                      setState(() => status = next);
                                    },
                                  ),
                                ),
                          onTap: () async {
                            await showDialog<Note>(
                              context: context,
                              builder: (context) => NoteDialog(
                                source: widget.source,
                                event: widget.event,
                                note: item,
                              ),
                            );
                            _pagingController.refresh();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                label: Text(AppLocalizations.of(context).create),
                icon: const Icon(Icons.add_outlined),
                onPressed: () async {
                  await showDialog<Note>(
                    context: context,
                    builder: (context) => NoteDialog(
                      event: widget.event,
                      source: widget.source,
                    ),
                  );
                  _pagingController.refresh();
                },
              ),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
