import 'dart:typed_data';

import 'package:flow/pages/notes/labels.dart';
import 'package:flow/pages/notes/note.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/note/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../../helpers/sourced_paging_controller.dart';
import 'filter.dart';
import 'card.dart';

class NotesPage extends StatefulWidget {
  final NoteFilter filter;
  final SourcedModel<Multihash>? parent;

  const NotesPage({
    super.key,
    this.parent,
    this.filter = const NoteFilter(),
  });

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late NoteFilter _filter;

  @override
  void initState() {
    super.initState();
    _filter = widget.filter;
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).notes,
      endDrawer: LabelsDrawer(
        selected: _filter.selectedLabel,
        onChanged: (value, add) {
          final source = value.source;
          if (add) {
            setState(() {
              _filter = _filter.copyWith(
                selectedLabel: value.model.id,
                source: source,
              );
            });
          } else {
            setState(() {
              _filter = _filter.copyWith(
                selectedLabel: null,
                source: null,
              );
            });
          }
        },
      ),
      actions: [
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
          onPressed: () => showSearch(
            context: context,
            delegate: _NotesSearchDelegate(
              _filter,
              widget.parent,
            ),
          ),
        ),
      ],
      body: NotesBodyView(
        filter: _filter,
        parent: widget.parent,
      ),
    );
  }
}

class _NotesSearchDelegate extends SearchDelegate {
  final NoteFilter filter;
  final SourcedModel<Multihash>? parent;

  _NotesSearchDelegate(this.filter, this.parent);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const PhosphorIcon(PhosphorIconsLight.x),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const PhosphorIcon(PhosphorIconsLight.arrowLeft),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return NotesBodyView(
      search: query,
      filter: filter,
      parent: parent,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class NotesBodyView extends StatefulWidget {
  final String search;
  final NoteFilter filter;
  final SourcedModel<Multihash>? parent;

  const NotesBodyView({
    super.key,
    this.search = '',
    this.filter = const NoteFilter(),
    this.parent,
  });

  @override
  State<NotesBodyView> createState() => _NotesBodyViewState();
}

class _NotesBodyViewState extends State<NotesBodyView> {
  late final FlowCubit _flowCubit;
  late final SourcedPagingController<Note> _controller;
  late NoteFilter _filter;

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _controller = SourcedPagingController(_flowCubit);
    _controller.addFetchListener((source, service, offset, limit) async {
      if (_filter.source != null && _filter.source != source) return null;
      final notes = _filter.selectedLabel != null
          ? await service.labelNote?.getNotes(
              _filter.selectedLabel!,
              offset: offset,
              limit: limit,
              statuses: _filter.statuses,
              parent: widget.parent?.source == source
                  ? widget.parent?.model
                  : Multihash(Uint8List.fromList([])),
              search: widget.search,
            )
          : await service.note?.getNotes(
              offset: offset,
              limit: limit,
              statuses: _filter.statuses,
              parent: widget.parent?.source == source
                  ? widget.parent?.model
                  : Multihash(Uint8List.fromList([])),
              search: widget.search);
      if (notes == null) return null;
      if (source != widget.parent?.source) return notes;
      final parent = await service.note?.getNote(widget.parent!.model);
      if (parent == null) return notes;
      return [
        parent,
        ...notes,
      ];
    });
    _filter = widget.filter;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant NotesBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      _controller.refresh();
    }
    if (oldWidget.filter != widget.filter) {
      setState(() {
        _filter = widget.filter;
      });
      _controller.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NoteFilterView(
            initialFilter: _filter,
            onChanged: (filter) {
              setState(() {
                _filter = filter;
              });
              _controller.refresh();
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: PagedListView(
              pagingController: _controller,
              builderDelegate: buildMaterialPagedDelegate<SourcedModel<Note>>(
                _controller,
                (ctx, item, index) {
                  final primary = item.source == widget.parent?.source &&
                      item.model.id == widget.parent?.model;
                  return Column(
                    children: [
                      NoteCard(
                        controller: _controller,
                        source: item.source,
                        note: item.model,
                        primary: primary,
                      ),
                      if (primary) ...[
                        const SizedBox(height: 8),
                        const Divider(),
                      ]
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog<Note>(
            context: context,
            builder: (context) => NoteDialog(
                  note: Note(
                    parentId: widget.parent?.model,
                  ),
                  source: widget.parent?.source,
                  create: true,
                )).then((_) => _controller.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }
}
