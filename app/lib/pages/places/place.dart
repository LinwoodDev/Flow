import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/place/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/source_dropdown.dart';

class PlaceDialog extends StatelessWidget {
  final String? source;
  final Place? place;
  const PlaceDialog({super.key, this.source, this.place});

  @override
  Widget build(BuildContext context) {
    var place = this.place ?? const Place();
    var currentSource = source ?? '';
    return AlertDialog(
      title: Text(source == null
          ? AppLocalizations.of(context).createPlace
          : AppLocalizations.of(context).editPlace),
      content: SizedBox(
        width: 500,
        child: Column(children: [
          if (source == null) ...[
            SourceDropdown(
              value: currentSource,
              onChanged: (String? value) {
                currentSource = value ?? '';
              },
            ),
            const SizedBox(height: 16),
          ],
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).name,
              filled: true,
              icon: const Icon(Icons.folder_outlined),
            ),
            initialValue: place.name,
            onChanged: (value) {
              place = place.copyWith(name: value);
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).description,
              border: const OutlineInputBorder(),
              icon: const Icon(Icons.description_outlined),
            ),
            minLines: 3,
            maxLines: 5,
            initialValue: place.description,
            onChanged: (value) {
              place = place.copyWith(description: value);
            },
          )
        ]),
      ),
      scrollable: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (source == null) {
              context
                  .read<FlowCubit>()
                  .getSource(currentSource)
                  .place
                  ?.createPlace(place);
            } else {
              context
                  .read<FlowCubit>()
                  .getSource(source!)
                  .place
                  ?.updatePlace(place);
            }
            Navigator.of(context).pop(place);
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
