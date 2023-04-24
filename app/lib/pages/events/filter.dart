import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lib5/lib5.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/model.dart';

import '../groups/select.dart';

part 'filter.freezed.dart';

@freezed
class EventFilter with _$EventFilter {
  const factory EventFilter({
    String? source,
    Multihash? group,
  }) = _EventFilter;
}

class EventFilterView extends StatefulWidget {
  final EventFilter? initialFilter;
  final ValueChanged<EventFilter> onChanged;
  const EventFilterView(
      {super.key, this.initialFilter, required this.onChanged});

  @override
  State<EventFilterView> createState() => _EventFilterViewState();
}

class _EventFilterViewState extends State<EventFilterView> {
  final ScrollController _scrollController = ScrollController();
  late EventFilter _filter;

  @override
  void initState() {
    _filter = widget.initialFilter ?? const EventFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InputChip(
              label: Text(AppLocalizations.of(context).group),
              avatar: Icon(Icons.folder_outlined,
                  color: _filter.group != null
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).iconTheme.color),
              selected: _filter.group != null,
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              labelStyle: TextStyle(
                  color: _filter.group != null
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : null),
              showCheckmark: false,
              deleteIconColor: Theme.of(context).colorScheme.onPrimaryContainer,
              onDeleted: _filter.group == null
                  ? null
                  : () {
                      setState(() {
                        _filter = _filter.copyWith(group: null, source: null);
                      });
                      widget.onChanged(_filter);
                    },
              onSelected: (value) async {
                final groupId = await showDialog<SourcedModel<Group>>(
                  context: context,
                  builder: (context) => GroupSelectDialog(
                    selected: _filter.source != null && _filter.group != null
                        ? SourcedModel(_filter.source!, _filter.group!)
                        : null,
                  ),
                );
                if (groupId != null) {
                  setState(() {
                    _filter = _filter.copyWith(
                        group: groupId.model.id, source: groupId.source);
                  });
                  widget.onChanged(_filter);
                }
              },
            ),
          ]
              .map((e) => Padding(padding: const EdgeInsets.all(8.0), child: e))
              .toList(),
        ),
      ),
    );
  }
}
