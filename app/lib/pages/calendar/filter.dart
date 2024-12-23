import 'package:dart_mappable/dart_mappable.dart';
import 'package:flow/helpers/event.dart';
import 'package:flow/pages/groups/select.dart';
import 'package:flow/pages/places/select.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/place/model.dart';

import '../events/select.dart';

part 'filter.mapper.dart';

@MappableClass()
class CalendarFilter with CalendarFilterMappable {
  final List<EventStatus> hiddenStatuses;
  final String? source;
  final Uint8List? group;
  final Uint8List? event;
  final Uint8List? place;
  final bool past;

  const CalendarFilter({
    this.hiddenStatuses = const [EventStatus.draft, EventStatus.cancelled],
    this.source,
    this.group,
    this.event,
    this.place,
    this.past = false,
  });

  SourcedModel<Uint8List>? get sourceEvent => event != null && source != null
      ? SourcedModel<Uint8List>(source!, event!)
      : null;

  CalendarFilter removePlace() => copyWith(
      place: null, source: (group != null && event != null) ? source : null);
  CalendarFilter removeGroup() => copyWith(
      group: null, source: (place != null && event != null) ? source : null);
  CalendarFilter removeEvent() => copyWith(
      event: null, source: (place != null && group != null) ? source : null);
}

class CalendarFilterView extends StatefulWidget {
  final CalendarFilter? initialFilter;
  final ValueChanged<CalendarFilter> onChanged;
  final bool past;

  const CalendarFilterView({
    super.key,
    this.initialFilter,
    required this.onChanged,
    this.past = false,
  });

  @override
  State<CalendarFilterView> createState() => _CalendarFilterViewState();
}

class _CalendarFilterViewState extends State<CalendarFilterView> {
  final ScrollController _scrollController = ScrollController();
  late CalendarFilter _filter;
  @override
  void initState() {
    _filter = widget.initialFilter ?? const CalendarFilter();
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
            ...EventStatus.values.map(
              (status) {
                final selected = !_filter.hiddenStatuses.contains(status);
                return InputChip(
                  label: Text(status.getLocalizedName(context)),
                  avatar: PhosphorIcon(status.icon(PhosphorIconsStyle.light)),
                  selected: selected,
                  selectedColor: status.getColor(),
                  showCheckmark: false,
                  onSelected: (value) {
                    setState(() {
                      if (value == true) {
                        _filter = _filter.copyWith(
                          hiddenStatuses: _filter.hiddenStatuses
                              .where((element) => element != status)
                              .toList(),
                        );
                      } else {
                        _filter = _filter.copyWith(
                          hiddenStatuses: [
                            ..._filter.hiddenStatuses,
                            status,
                          ],
                        );
                      }
                    });
                    widget.onChanged(_filter);
                  },
                );
              },
            ),
            InputChip(
              label: Text(AppLocalizations.of(context).event),
              avatar: const PhosphorIcon(PhosphorIconsLight.calendar),
              selected: _filter.event != null,
              showCheckmark: false,
              onDeleted: _filter.event == null
                  ? null
                  : () {
                      setState(() {
                        _filter = _filter.removeEvent();
                      });
                      widget.onChanged(_filter);
                    },
              onSelected: (value) async {
                final sourceGroup = await showDialog<SourcedModel<Event>>(
                  context: context,
                  builder: (context) => EventSelectDialog(
                    selected: _filter.source != null && _filter.event != null
                        ? SourcedModel(_filter.source!, _filter.event!)
                        : null,
                    source: _filter.source,
                  ),
                );
                if (sourceGroup != null) {
                  setState(() {
                    _filter = _filter.copyWith(
                        event: sourceGroup.model.id,
                        source: sourceGroup.source);
                  });
                  widget.onChanged(_filter);
                }
              },
            ),
            InputChip(
              label: Text(AppLocalizations.of(context).group),
              avatar: const PhosphorIcon(PhosphorIconsLight.folder),
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
                final sourceGroup = await showDialog<SourcedModel<Group>>(
                  context: context,
                  builder: (context) => GroupSelectDialog(
                    selected: _filter.source != null && _filter.group != null
                        ? SourcedModel(_filter.source!, _filter.group!)
                        : null,
                    source: _filter.source,
                  ),
                );
                if (sourceGroup != null) {
                  setState(() {
                    _filter = _filter.copyWith(
                        group: sourceGroup.model.id,
                        source: sourceGroup.source);
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
                final place = await showDialog<SourcedModel<Place>>(
                  context: context,
                  builder: (context) => PlaceSelectDialog(
                    selected: _filter.place != null && _filter.source != null
                        ? SourcedModel(_filter.source!, _filter.place!)
                        : null,
                    source: _filter.source,
                  ),
                );
                if (place != null) {
                  setState(() {
                    _filter = _filter.copyWith(
                        place: place.model.id, source: place.source);
                  });
                  widget.onChanged(_filter);
                }
              },
            ),
            if (widget.past)
              InputChip(
                label: Text(AppLocalizations.of(context).past),
                avatar: const PhosphorIcon(
                    PhosphorIconsLight.clockCounterClockwise),
                selected: _filter.past,
                showCheckmark: false,
                onSelected: (value) {
                  setState(() {
                    _filter = _filter.copyWith(past: value);
                  });
                  widget.onChanged(_filter);
                },
              )
          ]
              .map((e) => Padding(padding: const EdgeInsets.all(8.0), child: e))
              .toList(),
        ),
      ),
    );
  }
}
