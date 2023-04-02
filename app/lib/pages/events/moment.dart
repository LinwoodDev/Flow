import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/event.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/moment/model.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/note/model.dart';
import 'package:shared/models/note/service.dart';

import '../../widgets/date_time_field.dart';
import '../../widgets/source_dropdown.dart';
import '../notes/note.dart';
import 'event.dart';

class MomentDialog extends StatelessWidget {
  final bool create;
  final Moment? moment;
  final Event? event;
  final String? source;

  const MomentDialog({
    super.key,
    this.moment,
    this.event,
    this.source,
    this.create = false,
  });

  @override
  Widget build(BuildContext context) {
    var create = this.create || moment == null || source == null;
    var currentSource = source ?? '';
    var currentMoment = moment ??
        Moment(
          eventId: event?.id,
        );
    final nameController = TextEditingController(text: currentMoment.name);
    final descriptionController =
        TextEditingController(text: currentMoment.description);
    final locationController =
        TextEditingController(text: currentMoment.location);
    return AlertDialog(
      title: Text(create
          ? AppLocalizations.of(context).createMoment
          : AppLocalizations.of(context).editMoment),
      content: SizedBox(
        width: 500,
        height: 500,
        child: DefaultTabController(
          length: create ? 1 : 2,
          child: Column(
            children: [
              if (!create)
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
                          if (source == null) ...[
                            SourceDropdown(
                              value: currentSource,
                              onChanged: (String? value) {
                                currentSource = value ?? '';
                                currentMoment = currentMoment.copyWith(
                                  eventId: null,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                          ],
                          const SizedBox(height: 16),
                          EventListTile(
                            source: currentSource,
                            value: currentMoment.eventId,
                            onChanged: (value) {
                              currentMoment =
                                  currentMoment.copyWith(eventId: value);
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<EventStatus>(
                            value: currentMoment.status,
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
                              currentMoment = currentMoment.copyWith(
                                  status: value ?? currentMoment.status);
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
                            onChanged: (value) => currentMoment =
                                currentMoment.copyWith(name: value),
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
                            onChanged: (value) => currentMoment =
                                currentMoment.copyWith(description: value),
                          ),
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
                            onChanged: (value) => currentMoment =
                                currentMoment.copyWith(location: value),
                          ),
                          const SizedBox(height: 16),
                          DateTimeField(
                            label: AppLocalizations.of(context).time,
                            initialValue: currentMoment.time,
                            icon: const Icon(Icons.calendar_today_outlined),
                            onChanged: (value) {
                              currentMoment =
                                  currentMoment.copyWith(time: value);
                            },
                            canBeEmpty: true,
                          ),
                        ],
                      ),
                    ),
                    if (!create)
                      _MomentNotesTab(
                        moment: moment!,
                        event: event,
                        source: currentSource,
                      ),
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
            if (create) {
              final created = await context
                  .read<FlowCubit>()
                  .getService(currentSource)
                  .moment
                  ?.createMoment(currentMoment);
              if (created != null) {
                currentMoment = created;
              }
            } else {
              context
                  .read<FlowCubit>()
                  .getService(currentSource)
                  .moment
                  ?.updateMoment(currentMoment);
            }
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(currentMoment);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}

class _MomentNotesTab extends StatefulWidget {
  final Event? event;
  final Moment moment;
  final String source;
  const _MomentNotesTab(
      {required this.moment, required this.source, this.event});

  @override
  State<_MomentNotesTab> createState() => _MomentNotesTabState();
}

class _MomentNotesTabState extends State<_MomentNotesTab> {
  static const _pageSize = 20;

  late final NoteService? _noteService;

  final PagingController<int, Note> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _noteService = context.read<FlowCubit>().getService(widget.source).note;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _noteService?.getNotes(
          //eventId: widget.moment.id,
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
                  builderDelegate: buildMaterialPagedDelegate<Note>(
                    _pagingController,
                    (context, item, index) {
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
