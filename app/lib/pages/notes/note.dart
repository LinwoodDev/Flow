import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/note/model.dart';

class NoteDialog extends StatefulWidget {
  final String? source;
  final Note? note;
  const NoteDialog({super.key, this.source, this.note});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late Note _newNote;
  late String _newSource;

  @override
  void initState() {
    super.initState();

    _newNote = widget.note ?? const Note();
    _newSource = widget.source ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              widget.note == null
                  ? AppLocalizations.of(context).createNote
                  : AppLocalizations.of(context).editNote,
            ),
          ),
          if (_newNote.status != null)
            Checkbox(
              value: _newNote.status?.done,
              tristate: true,
              onChanged: (value) {
                setState(() {
                  _newNote = _newNote.copyWith(
                      status: NoteStatusExtension.fromDone(value));
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
              initialValue: _newNote.name,
              onChanged: (value) {
                _newNote = _newNote.copyWith(name: value);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).priority,
                icon: const Icon(Icons.priority_high_outlined),
                border: const OutlineInputBorder(),
              ),
              initialValue: _newNote.priority.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _newNote = _newNote.copyWith(
                    priority: int.tryParse(value) ?? _newNote.priority);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).description,
                icon: const Icon(Icons.description_outlined),
                border: const OutlineInputBorder(),
              ),
              initialValue: _newNote.description,
              minLines: 3,
              maxLines: 5,
              onChanged: (value) {
                _newNote = _newNote.copyWith(description: value);
              },
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: Text(AppLocalizations.of(context).todo),
              value: _newNote.status != null,
              onChanged: (value) {
                setState(() => _newNote = _newNote.copyWith(
                    status: value == true ? NoteStatus.todo : null));
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
                context.read<FlowCubit>().getSource(_newSource).note;
            if (widget.note == null) {
              service?.createNote(_newNote);
            } else {
              service?.updateNote(_newNote);
            }
            Navigator.of(context).pop();
          },
          child: Text(widget.note == null
              ? AppLocalizations.of(context).create
              : AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
