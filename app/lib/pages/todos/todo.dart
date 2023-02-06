import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/event/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/todo/model.dart';

class TodoDialog extends StatefulWidget {
  final String? source;
  final Event? event;
  final Todo? todo;
  const TodoDialog({super.key, this.source, this.event, this.todo});

  @override
  State<TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  late Todo _newTodo;
  late String _newSource;

  @override
  void initState() {
    super.initState();

    _newTodo = widget.todo ?? Todo(eventId: widget.event?.id);
    _newSource = widget.source ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              widget.todo == null
                  ? AppLocalizations.of(context).createTodo
                  : AppLocalizations.of(context).editTodo,
            ),
          ),
          Checkbox(
            value: _newTodo.status.done,
            tristate: true,
            onChanged: (value) {
              setState(() {
                _newTodo = _newTodo.copyWith(
                    status: TodoStatusExtension.fromDone(value));
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
            if (widget.source == null) ...[
              DropdownButtonFormField<String>(
                value: _newSource,
                items: context
                    .read<FlowCubit>()
                    .getCurrentSources()
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.isEmpty
                        ? AppLocalizations.of(context).local
                        : value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  _newSource = value ?? '';
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).source,
                  icon: const Icon(Icons.storage_outlined),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name,
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
                labelText: AppLocalizations.of(context).priority,
                icon: const Icon(Icons.priority_high_outlined),
                border: const OutlineInputBorder(),
              ),
              initialValue: _newTodo.priority.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _newTodo = _newTodo.copyWith(
                    priority: int.tryParse(value) ?? _newTodo.priority);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).description,
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
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final service =
                context.read<FlowCubit>().getSource(_newSource).todo;
            if (widget.todo == null) {
              service?.createTodo(_newTodo);
            } else {
              service?.updateTodo(_newTodo);
            }
            Navigator.of(context).pop();
          },
          child: Text(widget.todo == null
              ? AppLocalizations.of(context).create
              : AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
