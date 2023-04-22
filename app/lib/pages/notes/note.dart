import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/note/model.dart';
import 'package:shared/models/note/service.dart';

import '../../widgets/source_dropdown.dart';

class NoteDialog extends StatefulWidget {
  final String? source;
  final Note? note;
  final bool create;
  const NoteDialog({super.key, this.create = false, this.note, this.source});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late Note _newNote;
  late String _newSource;
  NoteService? _service;

  @override
  void initState() {
    super.initState();

    _newNote = widget.note ?? const Note();
    _newSource = widget.source ?? '';
    _service = context.read<FlowCubit>().getService(_newSource).note;
  }

  @override
  Widget build(BuildContext context) {
    final create =
        widget.create || widget.note == null || widget.source == null;
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              create
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
              SourceDropdown<NoteService>(
                value: _newSource,
                onChanged: (connected) {
                  _newSource = connected?.source ?? '';
                  _service = connected?.model;
                },
                buildService: (e) => e.note,
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
          onPressed: () async {
            final navigator = Navigator.of(context);
            Note? created;
            if (create) {
              created = await _service?.createNote(_newNote);
            } else {
              await _service?.updateNote(_newNote);
            }
            navigator.pop(created);
          },
          child: Text(create
              ? AppLocalizations.of(context).create
              : AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
