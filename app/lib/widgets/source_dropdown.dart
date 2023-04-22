import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/model.dart';
import 'package:shared/services/source.dart';

import '../cubits/flow.dart';

class SourceDropdown<T> extends StatelessWidget {
  final String value;
  final ValueChanged<ConnectedModel<String, T>?> onChanged;
  final T? Function(SourceService) buildService;

  const SourceDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.buildService,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FlowCubit>();
    final services = Map.fromEntries(cubit
        .getCurrentServicesMap()
        .entries
        .map((e) {
          final service = buildService(e.value);
          if (service == null) return null;
          return MapEntry(e.key, service);
        })
        .whereNotNull()
        .toList());
    final remotes = services.keys.map((e) => cubit.sourcesService.getRemote(e));
    return DropdownButtonFormField<String>(
      value: value,
      items: [
        DropdownMenuItem<String>(
          value: '',
          child: Text(AppLocalizations.of(context).local),
        ),
        ...services.entries.map<DropdownMenuItem<String>>((value) {
          final remote = cubit.sourcesService.getRemote(value.key);
          return DropdownMenuItem<String>(
            value: value.key,
            child: Text(remote?.displayName ?? value.key),
          );
        })
      ],
      selectedItemBuilder: (context) {
        return [
          Text(AppLocalizations.of(context).local),
          ...remotes.map<Widget>((value) => Text(value?.uri.host ?? ''))
        ];
      },
      onChanged: (value) {
        final service = services[value];
        onChanged(
          service == null
              ? null
              : ConnectedModel(
                  value!,
                  service,
                ),
        );
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).source,
        icon: const Icon(Icons.storage_outlined),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
