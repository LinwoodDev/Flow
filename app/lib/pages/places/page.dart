import 'package:flow/pages/places/place.dart';
import 'package:flow/widgets/builder_delegate.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared/models/place/model.dart';
import 'package:shared/models/model.dart';

import '../../cubits/flow.dart';
import '../../helpers/sourced_paging_controller.dart';
import 'tile.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({
    super.key,
  });

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).places,
      actions: [
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
          onPressed: () =>
              showSearch(context: context, delegate: _PlacesSearchDelegate()),
        ),
      ],
      body: const PlacesBodyView(),
    );
  }
}

class _PlacesSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const PhosphorIcon(PhosphorIconsLight.x),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const PhosphorIcon(PhosphorIconsLight.arrowLeft),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return PlacesBodyView(
      search: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class PlacesBodyView extends StatefulWidget {
  final String search;

  const PlacesBodyView({
    super.key,
    this.search = '',
  });

  @override
  State<PlacesBodyView> createState() => _PlacesBodyViewState();
}

class _PlacesBodyViewState extends State<PlacesBodyView> {
  late final FlowCubit _flowCubit;
  late final SourcedPagingController<Place> _controller;

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _controller = SourcedPagingController(_flowCubit);
    _controller.addFetchListener((source, service, offset, limit) async =>
        service.place?.getPlaces(offset: offset, limit: limit));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PlacesBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      _controller.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedListView(
        pagingController: _controller,
        builderDelegate: buildMaterialPagedDelegate<SourcedModel<Place>>(
          _controller,
          (ctx, item, index) => Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Dismissible(
                key: ValueKey('${item.model.id}@${item.source}'),
                onDismissed: (direction) async {
                  await _flowCubit
                      .getService(item.source)
                      .place
                      ?.deletePlace(item.model.id!);
                  _controller.itemList!.remove(item);
                },
                background: Container(
                  color: Colors.red,
                ),
                child: PlaceTile(
                  flowCubit: _flowCubit,
                  pagingController: _controller,
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
            .then((_) => _controller.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }
}
