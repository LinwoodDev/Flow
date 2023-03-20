import 'package:flow/helpers/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/note/model.dart';
import 'package:shared/models/note/service.dart';

import '../../cubits/flow.dart';

class NoteCard extends StatefulWidget {
  final String source;
  final Appointment? appointment;
  final Note note;
  final PagingController<int, MapEntry<Note, String>> controller;

  const NoteCard({
    super.key,
    required this.source,
    required this.appointment,
    required this.note,
    required this.controller,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late Note _newNote;
  Appointment? _appointment;
  late final NoteService? _noteService;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _appointment = widget.appointment;
    _nameController = TextEditingController(text: widget.note.name);
    _descriptionController =
        TextEditingController(text: widget.note.description);
    _newNote = widget.note;
    _noteService =
        context.read<FlowCubit>().getCurrentServicesMap()[widget.source]?.note;

    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        _newNote = _newNote.copyWith(name: _nameController.text);
        _updateNote();
      }
    });
    _descriptionFocus.addListener(() {
      if (!_descriptionFocus.hasFocus) {
        _newNote = _newNote.copyWith(description: _descriptionController.text);
        _updateNote();
      }
    });
  }

  @override
  void didUpdateWidget(covariant NoteCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.note != widget.note) {
      _nameController.text = widget.note.name;
      _descriptionController.text = widget.note.description;
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
                    [
                      Icons.delete_outlined,
                      AppLocalizations.of(context).delete,
                      () async {
                        await _noteService?.deleteNote(_newNote.id);
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
                    labelText: AppLocalizations.of(context).priority,
                    filled: true,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                  ),
                  textAlign: TextAlign.center,
                  initialValue: _newNote.priority.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _newNote = _newNote.copyWith(
                        priority: int.tryParse(value) ?? _newNote.priority);
                    _updateNote();
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
                      if (_appointment != null) ...[
                        if (widget.source.isNotEmpty)
                          Text(
                            widget.source,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              _appointment!.status.getIcon(),
                              color: _appointment!.status.getColor(),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context).eventInfo(
                                  _appointment!.name,
                                  _appointment?.start == null
                                      ? '-'
                                      : dateFormatter
                                          .format(_appointment!.start!),
                                  _appointment?.start == null
                                      ? '-'
                                      : timeFormatter
                                          .format(_appointment!.start!),
                                  _appointment!.location.isEmpty
                                      ? '-'
                                      : _appointment!.location,
                                  _appointment!.status
                                      .getLocalizedName(context),
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
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
                                  _newNote = _newNote.copyWith(eventId: null);
                                  _appointment = null;
                                  _updateNote();
                                },
                                icon: const Icon(Icons.delete_outlined),
                                tooltip:
                                    AppLocalizations.of(context).removeEvent,
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
                              AppLocalizations.of(context).noEvent,
                              style: Theme.of(context).textTheme.bodySmall,
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
                labelText: AppLocalizations.of(context).description,
                border: const OutlineInputBorder(),
              ),
              minLines: 3,
              maxLines: 5,
              onEditingComplete: () {
                _newNote =
                    _newNote.copyWith(description: _descriptionController.text);
                _updateNote();
              },
              onSaved: (value) {
                if (value == null) return;
                _newNote = _newNote.copyWith(description: value);
                _updateNote();
              },
              onFieldSubmitted: (value) {
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
