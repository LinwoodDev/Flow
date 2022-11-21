import 'package:flow/pages/calendar/filter.dart';
import 'package:flow/pages/places/place.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/place/model.dart';

import '../../cubits/flow.dart';

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
  final PagingController<int, MapEntry<Place, String>> _pagingController =
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
      final todos = <MapEntry<Place, String>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.place.getPlaces(
          offset: pageKey * _pageSize,
          limit: _pageSize,
        );
        todos.addAll(fetched.map((todo) => MapEntry(todo, source.key)));
        if (fetched.length < _pageSize) {
          isLast = true;
        }
      }
      if (isLast) {
        _pagingController.appendLastPage(todos);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(todos, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context)!.places,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () async {},
        ),
      ],
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: PagedListView(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<MapEntry<Place, String>>(
              itemBuilder: (ctx, item, index) => Dismissible(
                key: ValueKey(item.key.id),
                onDismissed: (direction) async {
                  await _flowCubit
                      .getSource(item.value)
                      .place
                      .deletePlace(item.key.id);
                  _pagingController.itemList!.remove(item);
                },
                background: Container(
                  color: Colors.red,
                ),
                child: PlaceTile(
                  flowCubit: _flowCubit,
                  pagingController: _pagingController,
                  source: item.value,
                  place: item.key,
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
        label: Text(AppLocalizations.of(context)!.create),
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
  final PagingController<int, MapEntry<Place, String>> pagingController;

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
            AppLocalizations.of(context)!.events,
            _openEvents,
          ],
          [
            Icons.delete_outline,
            AppLocalizations.of(context)!.delete,
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
        title: Text(AppLocalizations.of(context)!.deletePlace(place.name)),
        content: Text(
            AppLocalizations.of(context)!.deletePlaceDescription(place.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context)!.cancel,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await flowCubit.getSource(source).place.deletePlace(place.id);
              pagingController.itemList!.remove(MapEntry(
                place,
                source,
              ));
              pagingController.refresh();
            },
            child: Text(
              AppLocalizations.of(context)!.delete,
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
