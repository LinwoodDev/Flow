import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/models/todo/model.dart';

part 'filter.freezed.dart';

@freezed
class TodoFilter with _$TodoFilter {
  const factory TodoFilter({
    @Default(true) bool showDone,
    @Default(true) bool showInProgress,
    @Default(true) bool showTodo,
  }) = _TodoFilter;

  const TodoFilter._();

  Set<TodoStatus> get statuses {
    final statuses = <TodoStatus>{};
    if (showDone) statuses.add(TodoStatus.done);
    if (showInProgress) statuses.add(TodoStatus.inProgress);
    if (showTodo) statuses.add(TodoStatus.todo);
    return statuses;
  }
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
            label: Text(AppLocalizations.of(context)!.done),
            avatar: Icon(Icons.check_box_outlined,
                color: _filter.showDone
                    ? Colors.white
                    : Theme.of(context).iconTheme.color),
            selected: _filter.showDone,
            selectedColor: Theme.of(context).primaryColor,
            labelStyle:
                TextStyle(color: _filter.showDone ? Colors.white : null),
            showCheckmark: false,
            onSelected: (value) {
              setState(() {
                _filter = _filter.copyWith(showDone: value);
                widget.onChanged(_filter);
              });
            },
          ),
          InputChip(
            label: Text(AppLocalizations.of(context)!.inProgress),
            avatar: Icon(Icons.indeterminate_check_box_outlined,
                color: _filter.showInProgress
                    ? Colors.white
                    : Theme.of(context).iconTheme.color),
            selected: _filter.showInProgress,
            selectedColor: Theme.of(context).primaryColor,
            labelStyle:
                TextStyle(color: _filter.showInProgress ? Colors.white : null),
            showCheckmark: false,
            onSelected: (value) {
              setState(() {
                _filter = _filter.copyWith(showInProgress: value);
                widget.onChanged(_filter);
              });
            },
          ),
          InputChip(
            label: Text(AppLocalizations.of(context)!.todo),
            avatar: Icon(Icons.check_box_outline_blank_outlined,
                color: _filter.showTodo
                    ? Colors.white
                    : Theme.of(context).iconTheme.color),
            selected: _filter.showTodo,
            selectedColor: Theme.of(context).primaryColor,
            labelStyle:
                TextStyle(color: _filter.showTodo ? Colors.white : null),
            showCheckmark: false,
            onSelected: (value) {
              setState(() {
                _filter = _filter.copyWith(showTodo: value);
                widget.onChanged(_filter);
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
