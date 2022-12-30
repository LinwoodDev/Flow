import 'package:flow/helpers/event.dart';
import 'package:flow/pages/calendar/select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/todo/model.dart';
import 'package:shared/models/todo/service.dart';

import '../../cubits/flow.dart';
import '../calendar/event.dart';

class TodoCard extends StatefulWidget {
  final String source;
  final Event? event;
  final Todo todo;
  final PagingController<int, MapEntry<Todo, String>> controller;

  const TodoCard({
    super.key,
    required this.source,
    required this.event,
    required this.todo,
    required this.controller,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late Todo _newTodo;
  Event? _event;
  late final TodoService _todoService;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
    _nameController = TextEditingController(text: widget.todo.name);
    _descriptionController =
        TextEditingController(text: widget.todo.description);
    _newTodo = widget.todo;
    _todoService =
        context.read<FlowCubit>().getCurrentServicesMap()[widget.source]!.todo;

    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        _newTodo = _newTodo.copyWith(name: _nameController.text);
        _updateTodo();
      }
    });
    _descriptionFocus.addListener(() {
      if (!_descriptionFocus.hasFocus) {
        _newTodo = _newTodo.copyWith(description: _descriptionController.text);
        _updateTodo();
      }
    });
  }

  @override
  void didUpdateWidget(covariant TodoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.todo != widget.todo) {
      _nameController.text = widget.todo.name;
      _descriptionController.text = widget.todo.description;
      _newTodo = widget.todo;
    }
  }

  Future<void> _updateTodo() async {
    setState(() => _loading = true);
    await _todoService.updateTodo(
      _newTodo,
    );
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final dateFormatter = DateFormat.yMMMMd(locale);
    final timeFormatter = DateFormat.Hm(locale);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StatefulBuilder(builder: (context, setState) {
                  return Checkbox(
                    value: _newTodo.status.done,
                    tristate: true,
                    onChanged: (_) {
                      bool? newState;
                      if (_newTodo.status.done == null) {
                        newState = true;
                      } else if (_newTodo.status.done == true) {
                        newState = false;
                      } else {
                        newState = null;
                      }
                      setState(() {
                        _newTodo = _newTodo.copyWith(
                            status: TodoStatusExtension.fromDone(newState));
                        _updateTodo();
                      });
                    },
                  );
                }),
                const SizedBox(width: 8),
                Flexible(
                    child: TextFormField(
                  controller: _nameController,
                  style: Theme.of(context).textTheme.headline6,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: AppLocalizations.of(context)!.name,
                  ),
                  focusNode: _nameFocus,
                  onEditingComplete: () {
                    _newTodo = _newTodo.copyWith(name: _nameController.text);
                    _updateTodo();
                  },
                  onFieldSubmitted: (value) {
                    _newTodo = _newTodo.copyWith(name: value);
                    _updateTodo();
                  },
                )),
                const SizedBox(width: 8),
                PopupMenuButton(
                  itemBuilder: (context) => <dynamic>[
                    [
                      Icons.delete_outlined,
                      AppLocalizations.of(context)!.delete,
                      () async {
                        await _todoService.deleteTodo(_newTodo.id);
                        widget.controller.refresh();
                      }
                    ]
                  ]
                      .map((e) => PopupMenuItem(
                          onTap: e[2],
                          child: Row(children: [
                            Icon(e[0]),
                            const SizedBox(width: 8),
                            Text(e[1]),
                          ])))
                      .toList(),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(children: [
              SizedBox(
                width: 100,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.priority,
                    filled: true,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                  ),
                  textAlign: TextAlign.center,
                  initialValue: _newTodo.priority.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _newTodo = _newTodo.copyWith(
                        priority: int.tryParse(value) ?? _newTodo.priority);
                    _updateTodo();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_event != null) ...[
                        if (widget.source.isNotEmpty)
                          Text(
                            widget.source,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              _event!.status.getIcon(),
                              color: _event!.status.getColor(),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.eventInfo(
                                  _event!.name,
                                  _event?.start == null
                                      ? '-'
                                      : dateFormatter.format(_event!.start!),
                                  _event?.start == null
                                      ? '-'
                                      : timeFormatter.format(_event!.start!),
                                  _event!.location.isEmpty
                                      ? '-'
                                      : _event!.location,
                                  _event!.status.getLocalizedName(context),
                                ),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            if (_loading) ...[
                              const SizedBox(width: 8),
                              const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              ),
                            ] else ...[
                              IconButton(
                                onPressed: () async {
                                  _newTodo = _newTodo.copyWith(eventId: null);
                                  _event = null;
                                  _updateTodo();
                                },
                                icon: const Icon(Icons.delete_outlined),
                                tooltip:
                                    AppLocalizations.of(context)!.removeEvent,
                              ),
                            ]
                          ],
                        ),
                      ] else ...[
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.noEvent,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Wrap(
                              children: [
                                TextButton.icon(
                                  onPressed: () async {
                                    final event = await showDialog<Event>(
                                      context: context,
                                      builder: (context) => const EventDialog(),
                                    );
                                    if (event != null) {
                                      _newTodo =
                                          _newTodo.copyWith(eventId: event.id);
                                      _event = event;
                                      _updateTodo();
                                    }
                                  },
                                  icon: const Icon(Icons.add),
                                  label: Text(AppLocalizations.of(context)!
                                      .createEvent),
                                ),
                                TextButton.icon(
                                  onPressed: () async {
                                    final cubit = context.read<FlowCubit>();
                                    final result =
                                        await showDialog<MapEntry<String, int>>(
                                      context: context,
                                      builder: (context) => EventSelectDialog(
                                        source: widget.source,
                                      ),
                                    );
                                    if (result != null) {
                                      _newTodo = _newTodo.copyWith(
                                          eventId: result.value);
                                      _event = await cubit
                                          .getSource(result.key)
                                          .event
                                          .getEvent(result.value);
                                      _updateTodo();
                                    }
                                  },
                                  icon:
                                      const Icon(Icons.calendar_month_outlined),
                                  label: Text(AppLocalizations.of(context)!
                                      .assignEvent),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              focusNode: _descriptionFocus,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
                border: const OutlineInputBorder(),
              ),
              minLines: 3,
              maxLines: 5,
              onEditingComplete: () {
                _newTodo =
                    _newTodo.copyWith(description: _descriptionController.text);
                _updateTodo();
              },
              onSaved: (value) {
                if (value == null) return;
                _newTodo = _newTodo.copyWith(description: value);
                _updateTodo();
              },
              onFieldSubmitted: (value) {
                _newTodo = _newTodo.copyWith(description: value);
                _updateTodo();
              },
            ),
          ],
        ),
      ),
    );
  }
}
