import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/note/model.dart';
import 'package:shared/models/note/service.dart';

import '../../cubits/flow.dart';
import '../../widgets/builder_delegate.dart';
import '../notes/note.dart';

class NotesView<T extends DescriptiveModel> extends StatefulWidget {
  final T model;
  final String source;
  final NoteConnector<T> connector;

  const NotesView(
      {super.key,
      required this.source,
      required this.connector,
      required this.model});

  @override
  State<NotesView<T>> createState() => _NotesViewState();
}

class _NotesViewState<T extends DescriptiveModel> extends State<NotesView<T>> {
  static const _pageSize = 20;

  late final NoteService? _noteService;

  final PagingController<int, Note> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    final service = context.read<FlowCubit>().getService(widget.source);
    _noteService = service.note;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await widget.connector.getNotes(widget.model.id!,
          offset: pageKey * _pageSize, limit: _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      Stack(
        children: [
          Column(
            children: [
              Flexible(
                child: PagedListView<int, Note>(
                  pagingController: _pagingController,
                  builderDelegate: buildMaterialPagedDelegate<Note>(
                    _pagingController,
                    (context, item, index) {
                      var status = item.status;
                      return Dismissible(
                        key: ValueKey(item.id),
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          _noteService?.deleteNote(item.id!);
                          _pagingController.itemList!.remove(item);
                        },
                        child: ListTile(
                          title: Text(item.name),
                          leading: status == null
                              ? null
                              : StatefulBuilder(
                                  builder: (context, setState) => Checkbox(
                                    value: status?.done,
                                    tristate: true,
                                    onChanged: (_) async {
                                      bool? newState;
                                      if (status?.done == null) {
                                        newState = true;
                                      } else if (status?.done == true) {
                                        newState = false;
                                      } else {
                                        newState = null;
                                      }
                                      final next = NoteStatusExtension.fromDone(
                                          newState);
                                      _noteService?.updateNote(
                                          item.copyWith(status: next));
                                      setState(() => status = next);
                                    },
                                  ),
                                ),
                          onTap: () async {
                            await showDialog<Note>(
                              context: context,
                              builder: (context) => NoteDialog(
                                source: widget.source,
                                note: item,
                              ),
                            );
                            _pagingController.refresh();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                label: Text(AppLocalizations.of(context).create),
                icon: const Icon(Icons.add_outlined),
                onPressed: () async {
                  final note = await showDialog<Note>(
                    context: context,
                    builder: (context) => NoteDialog(
                      source: widget.source,
                    ),
                  );
                  if (note != null) {
                    await widget.connector.connect(widget.model.id!, note.id!);
                  }
                  _pagingController.refresh();
                },
              ),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
