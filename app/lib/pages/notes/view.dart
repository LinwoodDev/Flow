import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/pages/notes/select.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flow_api/models/note/service.dart';

import '../../cubits/flow.dart';
import 'note.dart';

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
  late final NoteService? _noteService;

  late final SourcedPagingBloc<Note> _bloc;

  @override
  void initState() {
    final cubit = context.read<FlowCubit>();
    final service = cubit.getService(widget.source);
    _noteService = service.note;
    _bloc = SourcedPagingBloc.source(
      cubit: cubit,
      source: widget.source,
      fetch: (service, offset, limit) => widget.connector
          .getItems(widget.model.id!, offset: offset, limit: limit),
    );
    super.initState();
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
                child: PagedListView<Note>.source(
                  bloc: _bloc,
                  itemBuilder: (context, item, index) {
                    var status = item.status;
                    return Dismissible(
                      key: ValueKey(item.id),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        widget.connector.disconnect(
                          widget.model.id!,
                          item.id!,
                        );
                        _bloc.removeSourced(item);
                      },
                      child: ListTile(
                        title: Text(item.name),
                        leading: status == null
                            ? null
                            : StatefulBuilder(
                                builder: (context, setState) => Checkbox(
                                  value: status?.isDone,
                                  tristate: true,
                                  onChanged: (_) async {
                                    bool? newState;
                                    if (status?.isDone == null) {
                                      newState = true;
                                    } else if (status?.isDone == true) {
                                      newState = false;
                                    } else {
                                      newState = null;
                                    }
                                    final next = NoteStatus.fromDone(newState);
                                    _noteService?.updateNote(
                                        item.copyWith(status: next));
                                    setState(() => status = next);
                                  },
                                ),
                              ),
                        onTap: () async {
                          await showDialog<SourcedModel<Note>>(
                            context: context,
                            builder: (context) => NoteDialog(
                              source: widget.source,
                              note: item,
                            ),
                          );
                          _bloc.refresh();
                        },
                      ),
                    );
                  },
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
                label: Text(AppLocalizations.of(context).link),
                icon: const PhosphorIcon(PhosphorIconsLight.link),
                onPressed: () async {
                  final note = await showDialog<SourcedModel<Note>>(
                    context: context,
                    builder: (context) => NoteSelectDialog(
                      source: widget.source,
                    ),
                  );
                  if (note != null) {
                    await widget.connector
                        .connect(widget.model.id!, note.model.id!);
                  }
                  _bloc.refresh();
                },
              ),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
