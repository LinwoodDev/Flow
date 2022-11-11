import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter.freezed.dart';

@freezed
class TodoFilter with _$TodoFilter {
  const factory TodoFilter({
    @Default(true) bool showCompleted,
    @Default(true) bool showIncompleted,
    @Default('') String search,
  }) = _TodoFilter;
}

class TodoFilterDialog extends StatefulWidget {
  final TodoFilter? initialFilter;
  const TodoFilterDialog({super.key, this.initialFilter});

  @override
  State<TodoFilterDialog> createState() => _TodoFilterDialogState();
}

class _TodoFilterDialogState extends State<TodoFilterDialog> {
  late TodoFilter _filter;

  @override
  void initState() {
    _filter = widget.initialFilter ?? const TodoFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.filter),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.completed),
            value: _filter.showCompleted,
            onChanged: (value) {
              setState(() {
                _filter = _filter.copyWith(showCompleted: value ?? false);
              });
            },
          ),
          CheckboxListTile(
            title: Text(AppLocalizations.of(context)!.incomplete),
            value: _filter.showIncompleted,
            onChanged: (value) {
              setState(() {
                _filter = _filter.copyWith(showIncompleted: value ?? false);
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_filter),
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
