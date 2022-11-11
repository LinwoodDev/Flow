import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/event/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/todo/model.dart';
import 'package:shared/models/todo/service.dart';

class EventTodoDialog extends StatefulWidget {
  final String source;
  final Event event;
  final Todo? todo;
  const EventTodoDialog(
      {super.key, required this.source, required this.event, this.todo});

  @override
  State<EventTodoDialog> createState() => _EventTodoDialogState();
}

class _EventTodoDialogState extends State<EventTodoDialog> {
  late Todo _newTodo;
  late final TodoService _todoService;

  @override
  void initState() {
    super.initState();

    _todoService = context.read<FlowCubit>().getSource(widget.source).todo;
    _newTodo = widget.todo ?? Todo(eventId: widget.event.id);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              widget.todo == null
                  ? AppLocalizations.of(context)!.createTodo
                  : AppLocalizations.of(context)!.editTodo,
            ),
          ),
          Checkbox(
            value: _newTodo.done,
            onChanged: (value) {
              setState(() {
                _newTodo = _newTodo.copyWith(done: value ?? _newTodo.done);
              });
            },
          ),
        ],
      ),
      scrollable: true,
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                icon: const Icon(Icons.title_outlined),
                filled: true,
              ),
              initialValue: _newTodo.name,
              onChanged: (value) {
                _newTodo = _newTodo.copyWith(name: value);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
                icon: const Icon(Icons.description_outlined),
                border: const OutlineInputBorder(),
              ),
              initialValue: _newTodo.description,
              minLines: 3,
              maxLines: 5,
              onChanged: (value) {
                _newTodo = _newTodo.copyWith(description: value);
              },
            ),
          ],
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
            if (widget.todo == null) {
              _todoService.createTodo(_newTodo);
            } else {
              _todoService.updateTodo(_newTodo);
            }
            Navigator.of(context).pop();
          },
          child: Text(widget.todo == null
              ? AppLocalizations.of(context)!.create
              : AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
