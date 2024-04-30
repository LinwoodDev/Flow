import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flow/pages/notes/label.dart';
import 'package:flow/widgets/builder_delegate.dart';
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

part 'children.dart';
part 'labels.dart';
part 'notebooks.dart';

class NotesNavigatorDrawer extends StatelessWidget {
  final String source;
  final Notebook? notebook;
  final Multihash? note, selectedLabel;
  final LabelChangedCallback? onLabelChanged;

  const NotesNavigatorDrawer({
    super.key,
    this.source = '',
    this.note,
    this.notebook,
    this.selectedLabel,
    this.onLabelChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sourcedNotebook =
        notebook == null ? null : SourcedModel(source, notebook);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          _NoteLabelsView(
            onChanged: onLabelChanged,
            selected: selectedLabel,
          ),
          TabBar(tabs: [
            HorizontalTab(
              label: Text(AppLocalizations.of(context).notes),
              icon: const PhosphorIcon(PhosphorIconsLight.article),
            ),
            HorizontalTab(
              label: Text(AppLocalizations.of(context).notebooks),
              icon: const PhosphorIcon(PhosphorIconsLight.fileArchive),
            ),
          ]),
          Expanded(
            child: TabBarView(
              children: [
                _NoteChildrenView(
                  parent: note,
                  notebook: sourcedNotebook,
                ),
                _NotebooksView(
                  model: sourcedNotebook,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
