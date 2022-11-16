import 'package:flow/helpers/event.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/models/event/model.dart';

part 'filter.freezed.dart';

@freezed
class CalendarFilter with _$CalendarFilter {
  const factory CalendarFilter({
    @Default([EventStatus.draft, EventStatus.cancelled])
        List<EventStatus> hiddenStatuses,
    @Default('') String search,
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
        children: [
          ...EventStatus.values.map(
            (status) {
              final selected = !_filter.hiddenStatuses.contains(status);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputChip(
                  label: Text(status.getLocalizedName(context)),
                  avatar: Icon(status.getIcon(),
                      color: selected
                          ? Colors.white
                          : Theme.of(context).iconTheme.color),
                  selected: selected,
                  selectedColor: status.getColor(),
                  labelStyle: TextStyle(color: selected ? Colors.white : null),
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
