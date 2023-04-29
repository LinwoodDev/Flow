import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flow/widgets/markdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/models/note/model.dart';
import 'package:shared/models/note/service.dart';

import '../../cubits/flow.dart';

class NoteCard extends StatefulWidget {
  final String source;
  final Note note;
  final SourcedPagingController<Note> controller;
  final bool primary;

  const NoteCard({
    super.key,
    required this.source,
    required this.note,
    required this.controller,
    this.primary = false,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  late final TextEditingController _nameController;
  late Note _newNote;
  late final NoteService? _noteService;

  final FocusNode _nameFocus = FocusNode();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.note.name);
    _newNote = widget.note;
    _noteService =
        context.read<FlowCubit>().getCurrentServicesMap()[widget.source]?.note;

    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        _newNote = _newNote.copyWith(name: _nameController.text);
        _updateNote();
      }
    });
  }

  @override
  void didUpdateWidget(covariant NoteCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.note != widget.note) {
      _nameController.text = widget.note.name;
      _newNote = widget.note;
    }
  }

  Future<void> _updateNote() async {
    setState(() => _loading = true);
    await _noteService?.updateNote(
      _newNote,
    );
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.primary ? 8 : 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (_newNote.status != null)
                  StatefulBuilder(builder: (context, setState) {
                    return Checkbox(
                      value: _newNote.status?.done,
                      tristate: true,
                      onChanged: (_) {
                        bool? newState;
                        if (_newNote.status?.done == null) {
                          newState = true;
                        } else if (_newNote.status?.done == true) {
                          newState = false;
                        } else {
                          newState = null;
                        }
                        setState(() {
                          _newNote = _newNote.copyWith(
                              status: NoteStatusExtension.fromDone(newState));
                          _updateNote();
                        });
                      },
                    );
                  }),
                const SizedBox(width: 8),
                Flexible(
                    child: TextFormField(
                  controller: _nameController,
                  style: Theme.of(context).textTheme.titleLarge,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: AppLocalizations.of(context).name,
                  ),
                  focusNode: _nameFocus,
                  onEditingComplete: () {
                    _newNote = _newNote.copyWith(name: _nameController.text);
                    _updateNote();
                  },
                  onFieldSubmitted: (value) {
                    _newNote = _newNote.copyWith(name: value);
                    _updateNote();
                  },
                )),
                const SizedBox(width: 8),
                PopupMenuButton(
                  itemBuilder: (context) => <dynamic>[
                    if (_newNote.status != null) ...[
                      [
                        Icons.notes_outlined,
                        AppLocalizations.of(context).convertToNote,
                        () async {
                          _newNote = _newNote.copyWith(status: null);
                          await _updateNote();
                        }
                      ],
                    ] else ...[
                      [
                        Icons.check_box_outlined,
                        AppLocalizations.of(context).convertToTodo,
                        () async {
                          _newNote = _newNote.copyWith(status: NoteStatus.todo);
                          await _updateNote();
                        }
                      ],
                    ],
                    [
                      Icons.delete_outlined,
                      AppLocalizations.of(context).delete,
                      () async {
                        await _noteService?.deleteNote(_newNote.id!);
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
                ),
                if (!widget.primary)
                  IconButton(
                    tooltip: AppLocalizations.of(context).open,
                    icon: const Icon(Icons.open_in_new_outlined),
                    onPressed: () {
                      GoRouter.of(context).pushNamed(
                        widget.source.isEmpty ? "subnote-local" : "subnote",
                        pathParameters: {
                          if (widget.source.isNotEmpty) "source": widget.source,
                          "id": widget.note.id!.toBase64Url(),
                        },
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).priority,
                          filled: true,
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                        textAlign: TextAlign.center,
                        initialValue: _newNote.priority.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _newNote = _newNote.copyWith(
                              priority:
                                  int.tryParse(value) ?? _newNote.priority);
                          _updateNote();
                        },
                      ),
                    ),
                    if (_loading) ...[
                      const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      ),
                    ]
                  ]),
            ),
            const SizedBox(height: 16),
            MarkdownField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).description,
                border: const OutlineInputBorder(),
              ),
              value: _newNote.description,
              onChangeEnd: (value) {
                _newNote = _newNote.copyWith(description: value);
                _updateNote();
              },
            ),
          ],
        ),
      ),
    );
  }
}
