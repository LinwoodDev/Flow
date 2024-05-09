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

class NotesNavigatorDrawer extends StatelessWidget {
  final Multihash? note;
  final ValueChanged<NoteFilter>? onFilterChanged;
  final NoteFilter filter;
  final bool isSearching;
  final SourcedPagingController<Note> controller;

  const NotesNavigatorDrawer({
    super.key,
    this.note,
    this.onFilterChanged,
    required this.filter,
    required this.controller,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context) {
    final sourcedNotebook = filter.notebook == null || filter.source == null
        ? null
        : SourcedModel(filter.source!, filter.notebook);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  if (note == null) ...[
                    _NotebooksView(
                      model: sourcedNotebook,
                      onChanged: (value) =>
                          onFilterChanged?.call(filter.copyWith(
                        notebook: value?.model,
                        source: value?.source,
                      )),
                    ),
                    const Divider(height: 32),
                  ],
                  _NoteLabelsView(
                    onChanged: onFilterChanged,
                    filter: filter,
                  ),
                ],
              ),
            ),
          ),
          if (note != null && !isSearching)
            Expanded(
              child: NotesListView(
                controller: controller,
              ),
            ),
        ],
      ),
    );
  }
}
