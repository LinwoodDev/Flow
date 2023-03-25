import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubits/flow.dart';

class SourceDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const SourceDropdown(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final remotes = context.read<FlowCubit>().getCurrentRemotes();
    return DropdownButtonFormField<String>(
      value: value,
      items: [
        DropdownMenuItem<String>(
          value: '',
          child: Text(AppLocalizations.of(context).local),
        ),
        ...remotes.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value.identifier,
            child: Text(value.displayName),
          );
        })
      ],
      selectedItemBuilder: (context) {
        return [
          Text(AppLocalizations.of(context).local),
          ...remotes.map<Widget>((value) => Text(value.uri.host))
        ];
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).source,
        icon: const Icon(Icons.storage_outlined),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
