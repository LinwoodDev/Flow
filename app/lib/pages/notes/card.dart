import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flow/widgets/color.dart';
import 'package:flow/widgets/markdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/label/model.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/note/label.dart';
import 'package:shared/models/note/model.dart';
import 'package:shared/models/note/service.dart';
import 'package:shared/services/source.dart';

import '../../cubits/flow.dart';
import 'label.dart';
import 'select.dart';

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
  late final FlowCubit _cubit;
  late final SourceService _sourceService;
  late final LabelNoteConnector? _labelNoteService;
  late final NoteService? _noteService;

  final FocusNode _nameFocus = FocusNode();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.note.name);
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
                if (!widget.primary)
                  IconButton(
                    tooltip: AppLocalizations.of(context).open,
                    icon: const PhosphorIcon(PhosphorIconsLight.arrowSquareOut),
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
                                            avatar: ColorPoint(
                                                color: Color(e.color)),
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
