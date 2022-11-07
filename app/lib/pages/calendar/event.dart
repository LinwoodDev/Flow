import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/event/service.dart';

import '../../widgets/date_time_field.dart';
import 'todo.dart';

class EventDialog extends StatelessWidget {
  final String? source;
  final Event? event;

  const EventDialog({super.key, this.event, this.source});

  @override
  Widget build(BuildContext context) {
    var event = this.event ?? const Event();
    var currentSource = source ?? '';
    final nameController = TextEditingController(text: event.name);
    final descriptionController =
        TextEditingController(text: event.description);
    final locationController = TextEditingController(text: event.location);
    return AlertDialog(
      title: Text(source == null
          ? AppLocalizations.of(context)!.createEvent
          : AppLocalizations.of(context)!.editEvent),
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
                  [Icons.tune_outlined, AppLocalizations.of(context)!.general],
                  [
                    Icons.check_circle_outline_outlined,
                    AppLocalizations.of(context)!.todos
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
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: 8),
                          if (source == null) ...[
                            DropdownButtonFormField<String>(
                              value: source,
                              items: <String>[
                                '',
                                'Google',
                                'Outlook',
                                'iCloud'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value.isEmpty
                                      ? AppLocalizations.of(context)!.local
                                      : value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                currentSource = value ?? '';
                              },
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.source,
                                icon: const Icon(Icons.storage_outlined),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          DropdownButtonFormField<EventStatus>(
                            value: event.status,
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
                              event =
                                  event.copyWith(status: value ?? event.status);
                            },
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.status,
                              icon: const Icon(Icons.info_outlined),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.name,
                              icon: const Icon(Icons.folder_outlined),
                            ),
                            onChanged: (value) =>
                                event = event.copyWith(name: value),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.description,
                              border: const OutlineInputBorder(),
                              icon: const Icon(Icons.description_outlined),
                            ),
                            minLines: 3,
                            maxLines: 5,
                            controller: descriptionController,
                            onChanged: (value) =>
                                event = event.copyWith(description: value),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.location,
                              filled: true,
                              icon: const Icon(Icons.location_on_outlined),
                            ),
                            minLines: 1,
                            maxLines: 2,
                            controller: locationController,
                            onChanged: (value) =>
                                event = event.copyWith(location: value),
                          ),
                          const SizedBox(height: 16),
                          DateTimeField(
                            label: AppLocalizations.of(context)!.start,
                            initialValue: event.start,
                            icon: const Icon(Icons.calendar_today_outlined),
                            onChanged: (value) {
                              event = event.copyWith(start: value);
                            },
                            canBeEmpty: true,
                          ),
                          const SizedBox(height: 8),
                          DateTimeField(
                            label: AppLocalizations.of(context)!.end,
                            initialValue: event.end,
                            icon: const Icon(Icons.calendar_today_outlined),
                            onChanged: (value) {
                              event = event.copyWith(end: value);
                            },
                            canBeEmpty: true,
                          ),
                        ],
                      ),
                    ),
                    if (source != null)
                      _EventTodosTab(event: event, source: source!),
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
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (source == null) {
              context
                  .read<FlowCubit>()
                  .getSource(currentSource)
                  .event
                  .createEvent(event);
            } else {
              context
                  .read<FlowCubit>()
                  .getSource(source!)
                  .event
                  .updateEvent(event);
            }
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}

class _EventTodosTab extends StatefulWidget {
  final Event event;
  final String source;
  const _EventTodosTab({required this.event, required this.source});

  @override
  State<_EventTodosTab> createState() => _EventTodosTabState();
}

class _EventTodosTabState extends State<_EventTodosTab> {
  static const _pageSize = 20;

  late final EventTodoService _todoService;

  final PagingController<int, EventTodo> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _todoService = context.read<FlowCubit>().getSource(widget.source).eventTodo;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _todoService.getTodos(
          eventId: widget.event.id,
          offset: pageKey * _pageSize,
          limit: _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
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
                child: PagedListView<int, EventTodo>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<EventTodo>(
                    itemBuilder: (context, item, index) => ListTile(
                      title: Text(item.name),
                      leading: Checkbox(
                        value: item.done,
                        onChanged: (value) async {
                          _todoService
                              .updateTodo(item.copyWith(done: value ?? false));
                          _pagingController.refresh();
                        },
                      ),
                      onTap: () async {
                        await showDialog<EventTodo>(
                          context: context,
                          builder: (context) => EventTodoDialog(
                            source: widget.source,
                            event: widget.event,
                            todo: item,
                          ),
                        );
                        _pagingController.refresh();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              label: Text(AppLocalizations.of(context)!.create),
              icon: const Icon(Icons.add_outlined),
              onPressed: () => showDialog<EventTodo>(
                context: context,
                builder: (context) => EventTodoDialog(
                  event: widget.event,
                  source: widget.source,
                ),
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
