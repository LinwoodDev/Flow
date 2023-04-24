import 'package:flow/pages/notes/note.dart';
import 'package:flow/pages/notes/filter.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lib5/lib5.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/note/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/builder_delegate.dart';
import 'card.dart';

class NotesPage extends StatefulWidget {
  final SourcedModel<Multihash>? parent;

  const NotesPage({Key? key, this.parent}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final PagingController<int, SourcedModel<Note>> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).notes,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () =>
              showSearch(context: context, delegate: _NotesSearchDelegate()),
        ),
      ],
      body: NotesBodyView(
        pagingController: _pagingController,
        parent: widget.parent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => NoteDialog(
            source: widget.parent?.source,
            create: true,
            note: Note(
              parentId: widget.parent?.model,
            ),
          ),
        ).then((value) => _pagingController.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}

class _NotesSearchDelegate extends SearchDelegate {
  final PagingController<int, SourcedModel<Note>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _pagingController.refresh();
    return NotesBodyView(
      pagingController: _pagingController,
      search: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class NotesBodyView extends StatefulWidget {
  final String search;
  final PagingController<int, SourcedModel<Note>> pagingController;
  final SourcedModel<Multihash>? parent;

  const NotesBodyView({
    super.key,
    this.search = '',
    this.parent,
    required this.pagingController,
  });

  @override
  State<NotesBodyView> createState() => _NotesBodyViewState();
}

class _NotesBodyViewState extends State<NotesBodyView> {
  static const _pageSize = 20;
  late final FlowCubit _flowCubit;
  NoteFilter _filter = const NoteFilter();

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    widget.pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  @override
  void dispose() {
    widget.pagingController.removePageRequestListener(_fetchPage);
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final sources = widget.parent == null
          ? _flowCubit.getCurrentServicesMap().entries
          : [
              MapEntry(widget.parent!.source,
                  _flowCubit.getService(widget.parent!.source))
            ];
      final notes = <SourcedModel<Note>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.note?.getNotes(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          statuses: _filter.statuses,
          search: widget.search,
          parent: widget.parent?.model,
        );
        if (fetched == null) continue;
        notes.addAll(fetched.map((note) => SourcedModel(source.key, note)));
        if (fetched.length < _pageSize) {
          isLast = true;
        }
      }
      if (pageKey == 0 && widget.parent != null) {
        final note = await _flowCubit
            .getService(widget.parent!.source)
            .note!
            .getNote(widget.parent!.model);
        if (note != null) {
          notes.insert(
            0,
            SourcedModel(widget.parent!.source, note),
          );
        }
      }
      if (isLast) {
        widget.pagingController.appendLastPage(notes);
      } else {
        final nextPageKey = pageKey + 1;
        widget.pagingController.appendPage(notes, nextPageKey);
      }
    } catch (error) {
      widget.pagingController.error = error;
    }
  }

  @override
  void didUpdateWidget(covariant NotesBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      widget.pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NoteFilterView(
          initialFilter: _filter,
          onChanged: (filter) {
            setState(() {
              _filter = filter;
              widget.pagingController.refresh();
            });
          },
        ),
        const SizedBox(height: 8),
        Flexible(
          child: PagedListView(
            pagingController: widget.pagingController,
            builderDelegate: buildMaterialPagedDelegate<SourcedModel<Note>>(
              widget.pagingController,
              (context, item, index) {
                final parent = index == 0 && widget.parent != null;
                return Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      children: [
                        NoteCard(
                          note: item.model,
                          source: item.source,
                          controller: widget.pagingController,
                          key: ValueKey('${item.model.id}@${item.source}'),
                          primary: parent,
                        ),
                        if (parent) ...[
                          const SizedBox(height: 8),
                          const Divider(),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
