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

class TodoFilterView extends StatefulWidget {
  final TodoFilter? initialFilter;
  final ValueChanged<TodoFilter> onChanged;
  const TodoFilterView(
      {super.key, this.initialFilter, required this.onChanged});

  @override
  State<TodoFilterView> createState() => _TodoFilterViewState();
}

class _TodoFilterViewState extends State<TodoFilterView> {
  late TodoFilter _filter;

  @override
  void initState() {
    _filter = widget.initialFilter ?? const TodoFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InputChip(
            label: Text(AppLocalizations.of(context)!.completed),
            avatar: Icon(Icons.check_box_outlined,
                color: _filter.showCompleted
                    ? Colors.white
                    : Theme.of(context).iconTheme.color),
            selected: _filter.showCompleted,
            selectedColor: Theme.of(context).primaryColor,
            labelStyle:
                TextStyle(color: _filter.showCompleted ? Colors.white : null),
            showCheckmark: false,
            onSelected: (value) {
              setState(() {
                _filter = _filter.copyWith(showCompleted: value);
              });
            },
          ),
          InputChip(
            label: Text(AppLocalizations.of(context)!.incomplete),
            avatar: Icon(Icons.check_box_outline_blank_outlined,
                color: _filter.showIncompleted
                    ? Colors.white
                    : Theme.of(context).iconTheme.color),
            selected: _filter.showIncompleted,
            selectedColor: Theme.of(context).primaryColor,
            labelStyle:
                TextStyle(color: _filter.showIncompleted ? Colors.white : null),
            showCheckmark: false,
            onSelected: (value) {
              setState(() {
                _filter = _filter.copyWith(showIncompleted: value);
              });
            },
          ),
        ]
            .map((e) => Padding(padding: const EdgeInsets.all(8.0), child: e))
            .toList(),
      ),
    );
  }
}
