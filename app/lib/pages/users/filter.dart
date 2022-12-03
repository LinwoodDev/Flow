import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../groups/select.dart';

part 'filter.freezed.dart';

@freezed
class UserFilter with _$UserFilter {
  const factory UserFilter({
    String? source,
    int? group,
  }) = _UserFilter;
}

class UserFilterView extends StatefulWidget {
  final UserFilter? initialFilter;
  final ValueChanged<UserFilter> onChanged;
  const UserFilterView(
      {super.key, this.initialFilter, required this.onChanged});

  @override
  State<UserFilterView> createState() => _UserFilterViewState();
}

class _UserFilterViewState extends State<UserFilterView> {
  late UserFilter _filter;

  @override
  void initState() {
    _filter = widget.initialFilter ?? const UserFilter();
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
                builder: (context) => GroupSelectDialog(
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
        ]
            .map((e) => Padding(padding: const EdgeInsets.all(8.0), child: e))
            .toList(),
      ),
    );
  }
}
