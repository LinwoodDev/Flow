import 'package:flow/pages/notes/note.dart';
import 'package:flow/pages/notes/filter.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/note/model.dart';

import '../../cubits/flow.dart';
import 'card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final PagingController<int, MapEntry<Note, String>> _pagingController =
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const NoteDialog(),
        ).then((value) => _pagingController.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}

class _NotesSearchDelegate extends SearchDelegate {
  final PagingController<int, MapEntry<Note, String>> _pagingController =
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
  final PagingController<int, MapEntry<Note, String>> pagingController;

  const NotesBodyView({
    super.key,
    this.search = '',
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
      final sources = _flowCubit.getCurrentServicesMap().entries;
      final notes = <MapEntry<Note, String>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.note?.getNotes(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          statuses: _filter.statuses,
          search: widget.search,
        );
        if (fetched == null) continue;
        notes.addAll(fetched.map((note) => MapEntry(note, source.key)));
        if (fetched.length < _pageSize) {
          isLast = true;
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
            builderDelegate: PagedChildBuilderDelegate<MapEntry<Note, String>>(
              itemBuilder: (context, item, index) => Align(
                alignment: Alignment.topCenter,
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: NoteCard(
                      note: item.key,
                      source: item.value,
                      controller: widget.pagingController,
                      key: ValueKey('${item.key.id}@${item.value}'),
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
