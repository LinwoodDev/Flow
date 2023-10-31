import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/services/source.dart';

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
    return Column(
      children: [
        const SizedBox(height: 16),
        DropdownMenu<String>(
          initialSelection: value,
          dropdownMenuEntries: services.entries.map((value) {
            final remote = cubit.sourcesService.getRemote(value.key);
            return DropdownMenuEntry<String>(
              value: value.key,
              label: remote?.displayName ?? AppLocalizations.of(context).local,
            );
          }).toList(),
          onSelected: (value) {
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
          label: Text(AppLocalizations.of(context).source),
          leadingIcon: const PhosphorIcon(PhosphorIconsLight.cloud),
          expandedInsets: const EdgeInsets.all(4),
        ),
      ],
    );
  }
}
