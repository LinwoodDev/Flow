import 'package:flow/helpers/event.dart';
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
    @Default('') String search,
  }) = _CalendarFilter;
}

class CalendarFilterDialog extends StatefulWidget {
  final CalendarFilter? initialFilter;

  const CalendarFilterDialog({super.key, this.initialFilter});

  @override
  State<CalendarFilterDialog> createState() => _CalendarFilterDialogState();
}

class _CalendarFilterDialogState extends State<CalendarFilterDialog> {
  late CalendarFilter _filter;
  @override
  void initState() {
    _filter = widget.initialFilter ?? const CalendarFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.filter),
      scrollable: true,
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...EventStatus.values.map(
              (status) => CheckboxListTile(
                title: Text(status.getLocalizedName(context)),
                secondary: Icon(status.getIcon()),
                value: !_filter.hiddenStatuses.contains(status),
                onChanged: (value) {
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
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_filter),
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
