import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flow/pages/notes/card.dart';
import 'package:flow/pages/notes/filter.dart';
import 'package:flow/pages/notes/label.dart';
import 'package:flow/pages/notes/notebook.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flow/widgets/select.dart';
import 'package:flow_api/models/label/model.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/note/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lib5/lib5.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_leap/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

part '../list.dart';
part 'labels.dart';
part 'notebooks.dart';

class NotesNavigatorDrawer extends StatefulWidget {
  final Multihash? note;
  final ValueChanged<NoteFilter>? onFilterChanged;
  final NoteFilter filter;

  const NotesNavigatorDrawer({
    super.key,
    this.note,
    this.onFilterChanged,
    required this.filter,
  });

  @override
  State<NotesNavigatorDrawer> createState() => _NotesNavigatorDrawerState();
}

class _NotesNavigatorDrawerState extends State<NotesNavigatorDrawer> {
  late final SourcedPagingController<Note> _controller;

  @override
  void initState() {
    super.initState();
    _controller = SourcedPagingController(context.read<FlowCubit>());
    _controller.addFetchListener(
        (source, service, offset, limit) async => service.note?.getNotes(
              offset: offset,
              limit: limit,
              notebook: widget.filter.notebook,
              parent: widget.note,
            ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sourcedNotebook =
        widget.filter.notebook == null || widget.filter.source == null
            ? null
            : SourcedModel(widget.filter.source!, widget.filter.notebook);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  if (widget.note == null) ...[
                    _NotebooksView(
                      model: sourcedNotebook,
                      onChanged: (value) =>
                          widget.onFilterChanged?.call(widget.filter.copyWith(
                        notebook: value?.model,
                        source: value?.source,
                      )),
                    ),
                    const Divider(height: 32),
                  ],
                  _NoteLabelsView(
                    onChanged: widget.onFilterChanged,
                    filter: widget.filter,
                  ),
                ],
              ),
            ),
          ),
          if (widget.note != null)
            Expanded(
              child: NotesListView(
                controller: _controller,
              ),
            ),
        ],
      ),
    );
  }
}
