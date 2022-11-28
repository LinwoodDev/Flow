import 'package:flow/helpers/event.dart';
import 'package:flow/pages/calendar/group.dart';
import 'package:flow/pages/calendar/place.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/models/event/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'filter.freezed.dart';

@freezed
class CalendarFilter with _$CalendarFilter {
  const factory CalendarFilter({
    @Default([EventStatus.draft, EventStatus.cancelled])
        List<EventStatus> hiddenStatuses,
    String? source,
    int? group,
    int? place,
    int? team,
    @Default(false) bool past,
  }) = _CalendarFilter;
}

class CalendarFilterView extends StatefulWidget {
  final CalendarFilter? initialFilter;
  final ValueChanged<CalendarFilter> onChanged;

  const CalendarFilterView(
      {super.key, this.initialFilter, required this.onChanged});

  @override
  State<CalendarFilterView> createState() => _CalendarFilterViewState();
}

class _CalendarFilterViewState extends State<CalendarFilterView> {
  late CalendarFilter _filter;
  @override
  void initState() {
    _filter = widget.initialFilter ?? const CalendarFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ...EventStatus.values.map(
            (status) {
              final selected = !_filter.hiddenStatuses.contains(status);
              return InputChip(
                label: Text(status.getLocalizedName(context)),
                avatar: Icon(status.getIcon(),
                    color: selected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).iconTheme.color),
                selected: selected,
                selectedColor: status.getColor(),
                labelStyle: TextStyle(
                    color: selected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : null),
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
            label: Text(AppLocalizations.of(context)!.group),
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
              final groupId = await showDialog<MapEntry<String, int>>(
                context: context,
                builder: (context) => EventGroupDialog(
                  selected: _filter.source != null && _filter.group != null
                      ? MapEntry(_filter.source!, _filter.group!)
                      : null,
                ),
              );
              if (groupId != null) {
                setState(() {
                  _filter = _filter.copyWith(
                      group: groupId.value, source: groupId.key);
                });
                widget.onChanged(_filter);
              }
            },
          ),
          InputChip(
            label: Text(AppLocalizations.of(context)!.place),
            avatar: Icon(Icons.location_on_outlined,
                color: _filter.place != null
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).iconTheme.color),
            selected: _filter.place != null,
            selectedColor: Theme.of(context).colorScheme.primaryContainer,
            labelStyle: TextStyle(
                color: _filter.place != null
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : null),
            showCheckmark: false,
            deleteIconColor: Theme.of(context).colorScheme.onPrimaryContainer,
            onDeleted: _filter.place == null
                ? null
                : () {
                    setState(() {
                      _filter = _filter.copyWith(place: null);
                    });
                    widget.onChanged(_filter);
                  },
            onSelected: (value) async {
              final placeId = await showDialog<MapEntry<String, int>>(
                context: context,
                builder: (context) => EventPlaceDialog(
                  selected: _filter.place != null
                      ? MapEntry(_filter.source!, _filter.group!)
                      : null,
                ),
              );
              if (placeId != null) {
                setState(() {
                  _filter = _filter.copyWith(
                      place: placeId.value, source: placeId.key);
                });
                widget.onChanged(_filter);
              }
            },
          ),
          InputChip(
            label: Text(AppLocalizations.of(context)!.team),
            avatar: Icon(Icons.groups_outlined,
                color: _filter.team != null
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).iconTheme.color),
            selected: _filter.team != null,
            selectedColor: Theme.of(context).colorScheme.primaryContainer,
            labelStyle: TextStyle(
                color: _filter.team != null
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : null),
            showCheckmark: false,
            deleteIconColor: Theme.of(context).colorScheme.onPrimaryContainer,
            onDeleted: _filter.team == null
                ? null
                : () {
                    setState(() {
                      _filter = _filter.copyWith(team: null, source: null);
                    });
                    widget.onChanged(_filter);
                  },
            onSelected: (value) async {
              final teamId = await showDialog<MapEntry<String, int>>(
                context: context,
                builder: (context) => EventGroupDialog(
                  selected: _filter.source != null && _filter.team != null
                      ? MapEntry(_filter.source!, _filter.team!)
                      : null,
                ),
              );
              if (teamId != null) {
                setState(() {
                  _filter =
                      _filter.copyWith(group: teamId.value, source: teamId.key);
                });
                widget.onChanged(_filter);
              }
            },
          ),
          InputChip(
            label: Text(AppLocalizations.of(context)!.past),
            avatar: Icon(Icons.history_outlined,
                color: _filter.past
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).iconTheme.color),
            selected: _filter.past,
            selectedColor: Theme.of(context).colorScheme.primaryContainer,
            labelStyle: TextStyle(
                color: _filter.past
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : null),
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
    );
  }
}
