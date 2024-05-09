import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flow/pages/notes/select.dart';
import 'package:flow/widgets/markdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/label/model.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/note/label.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flow_api/models/note/service.dart';
import 'package:flow_api/services/source.dart';

import '../../cubits/flow.dart';
import 'label.dart';

class NoteView extends StatefulWidget {
  final String source;
  final Note note;
  final SourcedPagingController<Note> controller;

  const NoteView({
    super.key,
    required this.source,
    required this.note,
    required this.controller,
  });

  @override
  State<NoteView> createState() => _NoteViewState();
}

enum PastePositing { line, selection }

class _NoteViewState extends State<NoteView> {
  late final TextEditingController _nameController, _descriptionController;
  late Note _newNote;
  late final FlowCubit _cubit;
  late final SourceService _sourceService;
  late final LabelNoteConnector? _labelNoteService;
  late final NoteService? _noteService;

  final FocusNode _nameFocus = FocusNode();

  bool _loading = false;

  final _formattingScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.note.name);
    _descriptionController =
        TextEditingController(text: widget.note.description);
    _newNote = widget.note;
    _cubit = context.read<FlowCubit>();
    _sourceService = _cubit.getService(widget.source);
    _labelNoteService = _sourceService.labelNote;
    _noteService = _sourceService.note;

    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) {
        _newNote = _newNote.copyWith(name: _nameController.text);
        _updateNote();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _nameFocus.dispose();
    _formattingScrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant NoteView oldWidget) {
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

  void _addDescription(PastePositing position, String text, [String? endText]) {
    var description = _descriptionController.text;
    final selection = _descriptionController.selection;
    if (!selection.isValid) return;
    final start = max(1, selection.start);
    final end = max(1, selection.end);
    final lineStart = description.lastIndexOf("\n", start - 1) + 1;
    description = switch (position) {
      PastePositing.line => description.substring(0, lineStart) +
          text +
          description.substring(lineStart),
      PastePositing.selection => description.substring(0, start) +
          text +
          description.substring(start, end) +
          (endText ?? text) +
          description.substring(end),
    };
    _descriptionController.text = description;
    _descriptionController.selection = TextSelection.collapsed(
      offset: start + text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                MenuAnchor(
                  builder: defaultMenuButton(),
                  menuChildren: [
                    if (_newNote.status != null) ...[
                      (
                        PhosphorIconsLight.note,
                        AppLocalizations.of(context).convertToNote,
                        () async {
                          _newNote = _newNote.copyWith(status: null);
                          await _updateNote();
                        }
                      ),
                    ] else ...[
                      (
                        PhosphorIconsLight.checkSquare,
                        AppLocalizations.of(context).convertToTodo,
                        () async {
                          _newNote = _newNote.copyWith(status: NoteStatus.todo);
                          await _updateNote();
                        }
                      ),
                    ],
                    (
                      PhosphorIconsLight.trash,
                      AppLocalizations.of(context).delete,
                      () async {
                        await _noteService?.deleteNote(_newNote.id!);
                        widget.controller.refresh();
                      }
                    )
                  ]
                      .map((e) => MenuItemButton(
                            leadingIcon: PhosphorIcon(e.$1),
                            onPressed: e.$3,
                            child: Text(e.$2),
                          ))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(children: [
                SizedBox(
                  height: 16,
                  width: 16,
                  child: _loading ? const CircularProgressIndicator() : null,
                ),
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
                Expanded(
                  child: SizedBox(
                    height: 70,
                    child: FutureBuilder<List<Label>>(
                        future: Future.value(
                            _labelNoteService?.getConnected(_newNote.id!)),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const SizedBox();
                          final labels = snapshot.data!;
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                children: labels
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InputChip(
                                            avatar: ColorButton(
                                              color: Color(e.color),
                                            ),
                                            label: Text(e.name),
                                            onDeleted: () async {
                                              await _labelNoteService
                                                  ?.disconnect(
                                                      e.id!, _newNote.id!);
                                              setState(() {});
                                            },
                                          ),
                                        ))
                                    .toList(),
                              ),
                              Align(
                                child: IconButton(
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.plusCircle),
                                  onPressed: () async {
                                    final label =
                                        await showDialog<SourcedModel<Label>>(
                                      context: context,
                                      builder: (context) => LabelDialog(
                                        source: widget.source,
                                      ),
                                    );
                                    if (label != null) {
                                      await _labelNoteService?.connect(
                                        label.model.id!,
                                        _newNote.id!,
                                      );
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                              Align(
                                child: IconButton(
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.link),
                                  onPressed: () async {
                                    final label =
                                        await showDialog<SourcedModel<Label>>(
                                      context: context,
                                      builder: (context) => LabelSelectDialog(
                                        source: widget.source,
                                      ),
                                    );
                                    if (label != null) {
                                      await _labelNoteService?.connect(
                                        label.model.id!,
                                        _newNote.id!,
                                      );
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ]),
            ),
            MarkdownField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).description,
                border: const OutlineInputBorder(),
              ),
              toolbar: SizedBox(
                height: 50,
                child: Scrollbar(
                  controller: _formattingScrollController,
                  child: ListView(
                      controller: _formattingScrollController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...[
                          PhosphorIconsLight.textHOne,
                          PhosphorIconsLight.textHTwo,
                          PhosphorIconsLight.textHThree,
                          PhosphorIconsLight.textHFour,
                          PhosphorIconsLight.textHFive,
                          PhosphorIconsLight.textHSix
                        ].mapIndexed((index, element) => IconButton(
                              icon: PhosphorIcon(element),
                              onPressed: () => _addDescription(
                                PastePositing.line,
                                "${"#" * (index + 1)} ",
                              ),
                            )),
                        ...[
                          (
                            '```',
                            PhosphorIconsLight.codeSimple,
                            AppLocalizations.of(context).codeBlock
                          ),
                          (
                            '>',
                            PhosphorIconsLight.quotes,
                            AppLocalizations.of(context).quote
                          ),
                          (
                            '- ',
                            PhosphorIconsLight.list,
                            AppLocalizations.of(context).list
                          ),
                          (
                            '1. ',
                            PhosphorIconsLight.listNumbers,
                            AppLocalizations.of(context).numberedList
                          ),
                        ].map((e) => IconButton(
                              icon: PhosphorIcon(e.$2),
                              tooltip: e.$3,
                              onPressed: () => _addDescription(
                                PastePositing.line,
                                e.$1,
                              ),
                            )),
                        const SizedBox(width: 8),
                        ...[
                          (
                            '**',
                            PhosphorIconsLight.textB,
                            AppLocalizations.of(context).bold
                          ),
                          (
                            '*',
                            PhosphorIconsLight.textItalic,
                            AppLocalizations.of(context).italic
                          ),
                          (
                            '~~',
                            PhosphorIconsLight.textStrikethrough,
                            AppLocalizations.of(context).strikethrough
                          ),
                          (
                            '`',
                            PhosphorIconsLight.code,
                            AppLocalizations.of(context).code
                          ),
                        ].map((e) => IconButton(
                              icon: PhosphorIcon(e.$2),
                              tooltip: e.$3,
                              onPressed: () => _addDescription(
                                PastePositing.selection,
                                e.$1,
                              ),
                            )),
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.link),
                          tooltip: AppLocalizations.of(context).link,
                          onPressed: () => _addDescription(
                            PastePositing.selection,
                            '[',
                            ']()',
                          ),
                        ),
                      ]),
                ),
              ),
              controller: _descriptionController,
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
