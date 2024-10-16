import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/place/model.dart';

import '../groups/select.dart';
import '../places/select.dart';

part 'filter.freezed.dart';

@freezed
class EventFilter with _$EventFilter {
  const EventFilter._();

  const factory EventFilter({
    String? source,
    Multihash? group,
    Multihash? place,
  }) = _EventFilter;

  EventFilter removeGroup() =>
      copyWith(group: null, source: place != null ? source : null);
  EventFilter removePlace() =>
      copyWith(place: null, source: group != null ? source : null);
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
            InputChip(
              label: Text(AppLocalizations.of(context).place),
              avatar: const PhosphorIcon(PhosphorIconsLight.mapPin),
              selected: _filter.place != null,
              showCheckmark: false,
              onDeleted: _filter.place == null
                  ? null
                  : () {
                      setState(() {
                        _filter = _filter.removePlace();
                      });
                      widget.onChanged(_filter);
                    },
              onSelected: (value) async {
                final placeId = await showDialog<SourcedModel<Place>>(
                  context: context,
                  builder: (context) => PlaceSelectDialog(
                    selected: _filter.source != null && _filter.place != null
                        ? SourcedModel(_filter.source!, _filter.place!)
                        : null,
                    source: _filter.source,
                  ),
                );
                if (placeId != null) {
                  setState(() {
                    _filter = _filter.copyWith(
                        place: placeId.model.id, source: placeId.source);
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
