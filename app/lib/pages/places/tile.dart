import 'package:flow/helpers/sourced_paging_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/place/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/markdown_field.dart';
import '../calendar/filter.dart';
import 'place.dart';

class PlaceTile extends StatelessWidget {
  const PlaceTile({
    Key? key,
    required this.source,
    required this.place,
    required this.flowCubit,
    required this.pagingController,
  }) : super(key: key);

  final FlowCubit flowCubit;
  final Place place;
  final String source;
  final SourcedPagingController<Place> pagingController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.name),
      subtitle: MarkdownText(place.description),
      onTap: () => _editPlace(context),
      trailing: MenuAnchor(
        builder: defaultMenuButton(),
        menuChildren: [
          (
            PhosphorIconsLight.calendar,
            AppLocalizations.of(context).events,
            _openEvents,
          ),
          (
            PhosphorIconsLight.trash,
            AppLocalizations.of(context).delete,
            _deletePlace,
          ),
        ]
            .map((e) => MenuItemButton(
                  leadingIcon: PhosphorIcon(e.$1),
                  child: Text(e.$2),
                  onPressed: () => e.$3(context),
                ))
            .toList(),
      ),
    );
  }

  void _deletePlace(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deletePlace(place.name)),
        content: Text(
            AppLocalizations.of(context).deletePlaceDescription(place.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context).cancel,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await flowCubit.getService(source).place?.deletePlace(place.id!);
              pagingController.itemList!.remove(SourcedModel(
                source,
                place,
              ));
              pagingController.refresh();
            },
            child: Text(
              AppLocalizations.of(context).delete,
            ),
          ),
        ],
      ),
    );
  }

  void _openEvents(BuildContext context) {
    GoRouter.of(context).go(
      "/calendar",
      extra: CalendarFilter(
        place: place.id,
        source: source,
      ),
    );
  }

  void _editPlace(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PlaceDialog(
        place: place,
        source: source,
      ),
    ).then((value) => pagingController.refresh());
  }
}
