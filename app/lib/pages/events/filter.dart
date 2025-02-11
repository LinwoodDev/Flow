import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:typed_data';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/models/model.dart';

import '../groups/select.dart';

part 'filter.mapper.dart';

@MappableClass()
class EventFilter with EventFilterMappable {
  final String? source;
  final Uint8List? group;

  const EventFilter({
    this.source,
    this.group,
  });

  EventFilter removeGroup() => copyWith(group: null, source: source);
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
              avatar: const PhosphorIcon(PhosphorIconsLight.fileText),
              selected: _filter.group != null,
              showCheckmark: false,
              onDeleted: _filter.group == null
                  ? null
                  : () {
                      setState(() {
                        _filter = _filter.removeGroup();
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
                    source: _filter.source,
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
