import 'package:flow/pages/calendar/filter.dart';
import 'package:flow/pages/places/place.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/place/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/builder_delegate.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({
    super.key,
  });

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  static const _pageSize = 20;
  late final FlowCubit _flowCubit;
  final PagingController<int, SourcedModel<Place>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final sources = _flowCubit.getCurrentServicesMap().entries;
      final places = <SourcedModel<Place>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.place?.getPlaces(
          offset: pageKey * _pageSize,
          limit: _pageSize,
        );
        if (fetched == null) continue;
        places.addAll(fetched.map((place) => SourcedModel(source.key, place)));
        if (fetched.length < _pageSize) {
          isLast = true;
        }
      }
      if (isLast) {
        _pagingController.appendLastPage(places);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(places, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).places,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: PagedListView(
            pagingController: _pagingController,
            builderDelegate: buildMaterialPagedDelegate<SourcedModel<Place>>(
              _pagingController,
              (ctx, item, index) => Dismissible(
                key: ValueKey('${item.model.id}@${item.source}'),
                onDismissed: (direction) async {
                  await _flowCubit
                      .getService(item.source)
                      .place
                      ?.deletePlace(item.model.id);
                  _pagingController.itemList!.remove(item);
                },
                background: Container(
                  color: Colors.red,
                ),
                child: PlaceTile(
                  flowCubit: _flowCubit,
                  pagingController: _pagingController,
                  source: item.source,
                  place: item.model,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
                context: context, builder: (context) => const PlaceDialog())
            .then((value) => _pagingController.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const Icon(Icons.add_outlined),
      ),
    );
  }
}

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
  final PagingController<int, SourcedModel<Place>> pagingController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.name),
      subtitle: Text(place.description),
      onTap: () => _editPlace(context),
      trailing: PopupMenuButton<Function>(
        itemBuilder: (ctx) => <dynamic>[
          [
            Icons.calendar_month_outlined,
            AppLocalizations.of(context).events,
            _openEvents,
          ],
          [
            Icons.delete_outline,
            AppLocalizations.of(context).delete,
            _deletePlace,
          ],
        ]
            .map((e) => PopupMenuItem<Function>(
                  value: e[2],
                  child: Row(
                    children: [
                      Icon(e[0]),
                      const SizedBox(width: 8),
                      Text(e[1]),
                    ],
                  ),
                ))
            .toList(),
        onSelected: (value) => value(context),
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
              await flowCubit.getService(source).place?.deletePlace(place.id);
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
