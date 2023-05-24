import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/note/model.dart';

part 'filter.freezed.dart';

@freezed
class NoteFilter with _$NoteFilter {
  const factory NoteFilter({
    @Default(true) bool showDone,
    @Default(true) bool showInProgress,
    @Default(true) bool showTodo,
    @Default(true) bool showNote,
    @Default([]) List<SourcedModel<Multihash>> selectedLabels,
    String? source,
  }) = _NoteFilter;

  const NoteFilter._();

  Set<NoteStatus?> get statuses {
    return {
      if (showDone) NoteStatus.done,
      if (showInProgress) NoteStatus.inProgress,
      if (showTodo) NoteStatus.todo,
      if (showNote) null,
    };
  }
}

class NoteFilterView extends StatefulWidget {
  final NoteFilter? initialFilter;
  final ValueChanged<NoteFilter> onChanged;
  const NoteFilterView(
      {super.key, this.initialFilter, required this.onChanged});

  @override
  State<NoteFilterView> createState() => _NoteFilterViewState();
}

class _NoteFilterViewState extends State<NoteFilterView> {
  late NoteFilter _filter;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _filter = widget.initialFilter ?? const NoteFilter();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NoteFilterView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialFilter != widget.initialFilter) {
      setState(() {
        _filter = widget.initialFilter ?? const NoteFilter();
      });
    }
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
              label: Text(AppLocalizations.of(context).done),
              avatar: PhosphorIcon(PhosphorIconsLight.checkSquare,
                  color: _filter.showDone
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).iconTheme.color),
              selected: _filter.showDone,
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              labelStyle: TextStyle(
                  color: _filter.showDone
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : null),
              showCheckmark: false,
              onSelected: (value) {
                setState(() {
                  _filter = _filter.copyWith(showDone: value);
                  widget.onChanged(_filter);
                });
              },
            ),
            InputChip(
              label: Text(AppLocalizations.of(context).inProgress),
              avatar: PhosphorIcon(PhosphorIconsLight.minusSquare,
                  color: _filter.showInProgress
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).iconTheme.color),
              selected: _filter.showInProgress,
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              labelStyle: TextStyle(
                  color: _filter.showInProgress
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : null),
              showCheckmark: false,
              onSelected: (value) {
                setState(() {
                  _filter = _filter.copyWith(showInProgress: value);
                  widget.onChanged(_filter);
                });
              },
            ),
            InputChip(
              label: Text(AppLocalizations.of(context).todo),
              avatar: PhosphorIcon(PhosphorIconsLight.square,
                  color: _filter.showTodo
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).iconTheme.color),
              selected: _filter.showTodo,
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              labelStyle: TextStyle(
                  color: _filter.showTodo
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : null),
              showCheckmark: false,
              onSelected: (value) {
                setState(() {
                  _filter = _filter.copyWith(showTodo: value);
                  widget.onChanged(_filter);
                });
              },
            ),
            InputChip(
              label: Text(AppLocalizations.of(context).note),
              avatar: PhosphorIcon(PhosphorIconsLight.note,
                  color: _filter.showNote
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).iconTheme.color),
              selected: _filter.showNote,
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              labelStyle: TextStyle(
                  color: _filter.showNote
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : null),
              showCheckmark: false,
              onSelected: (value) {
                setState(() {
                  _filter = _filter.copyWith(showNote: value);
                  widget.onChanged(_filter);
                });
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
