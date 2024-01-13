import 'package:flow/cubits/flow.dart';
import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flow/pages/notes/label.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flow/widgets/color.dart';
import 'package:flow_api/models/label/model.dart';
import 'package:flow_api/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lib5/lib5.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

part 'labels.dart';

class NotesNavigatorDrawer extends StatelessWidget {
  final Multihash? selectedLabel;
  final LabelChangedCallback? onLabelChanged;

  const NotesNavigatorDrawer({
    super.key,
    this.selectedLabel,
    this.onLabelChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpansionPanelList.radio(
          children: [
            ExpansionPanel(
              headerBuilder: (context, isExpanded) => ListTile(
                title: Text(AppLocalizations.of(context).labels),
              ),
              body: _NoteLabelsView(
                onChanged: onLabelChanged,
                selected: selectedLabel,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
