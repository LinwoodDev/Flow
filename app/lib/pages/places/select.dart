import 'package:flow/cubits/flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lib5/lib5.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/place/model.dart';
import 'package:flow_api/services/source.dart';

import '../../widgets/builder_delegate.dart';
import 'place.dart';

class PlaceSelectTile extends StatefulWidget {
  final String source;
  final Multihash? value;
  final ValueChanged<Multihash?> onChanged;

  const PlaceSelectTile({
    super.key,
    required this.source,
    this.value,
    required this.onChanged,
  });

  @override
  State<PlaceSelectTile> createState() => _PlaceSelectTileState();
}

class _PlaceSelectTileState extends State<PlaceSelectTile> {
  Multihash? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _onChanged(Multihash? value) {
    setState(() {
      _value = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Place?>(
        future: Future.value(_value == null
            ? null
            : context
                .read<FlowCubit>()
                .getService(widget.source)
                .place
                ?.getPlace(_value!)),
        builder: (context, snapshot) {
          final place = snapshot.data;
          return ListTile(
            title: Text(AppLocalizations.of(context).place),
            subtitle: Text(place?.name ?? AppLocalizations.of(context).notSet),
            leading: PhosphorIcon(PhosphorIcons.mapPin(place == null
                ? PhosphorIconsStyle.light
                : PhosphorIconsStyle.fill)),
            onTap: () async {
              if (place != null) {
                Navigator.of(context).pop();
                final model = await showDialog<SourcedModel<Place>>(
                  context: context,
                  builder: (context) => PlaceDialog(
                    place: place,
                    source: widget.source,
                  ),
                );
                if (model != null) {
                  _onChanged(model.model.id);
                }
              } else {
                final model = await showDialog<SourcedModel<Place>>(
                  context: context,
                  builder: (context) => PlaceSelectDialog(
                    source: widget.source,
                  ),
                );
                if (model != null) {
                  _onChanged(model.model.id);
                }
              }
            },
            trailing: _value == null
                ? IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.plusCircle),
                    onPressed: () async {
                      final place = await showDialog<SourcedModel<Place>>(
                        context: context,
                        builder: (context) => PlaceDialog(
                          source: widget.source,
                          create: true,
                        ),
                      );
                      _onChanged(place?.model.id);
                    },
                  )
                : IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.x),
                    onPressed: () {
                      _onChanged(null);
                    },
                  ),
          );
        });
  }
}

class PlaceSelectDialog extends StatefulWidget {
  final String? source;
  final SourcedModel<Multihash>? selected;

  const PlaceSelectDialog({
    super.key,
    this.source,
    this.selected,
  });

  @override
  State<PlaceSelectDialog> createState() => _PlaceSelectDialogState();
}

class _PlaceSelectDialogState extends State<PlaceSelectDialog> {
  static const _pageSize = 20;
  final TextEditingController _controller = TextEditingController();
  final PagingController<int, SourcedModel<Place>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(_fetchPage);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final cubit = context.read<FlowCubit>();
      Map<String, SourceService> sources = widget.source == null
          ? cubit.getCurrentServicesMap()
          : {widget.source!: cubit.getService(widget.source!)};
      final places = await Future.wait(sources.entries.map((source) async {
        final places = await source.value.place?.getPlaces(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          search: _controller.text,
        );
        return (places ?? <Place>[])
            .map((place) => SourcedModel(source.key, place))
            .toList();
      }));
      final allPlaces = places.expand((element) => element).toList();
      final isLast = places.length < _pageSize;
      if (isLast) {
        _pagingController.appendLastPage(allPlaces);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(allPlaces, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).place),
      content: SizedBox(
        height: 400,
        width: 400,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).search,
                icon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
              ),
              controller: _controller,
              onSubmitted: (_) {
                _pagingController.refresh();
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: PagedListView<int, SourcedModel<Place>>(
                pagingController: _pagingController,
                builderDelegate:
                    buildMaterialPagedDelegate<SourcedModel<Place>>(
                  _pagingController,
                  (context, item, index) => ListTile(
                    title: Text(item.model.name),
                    selected: widget.selected?.model == item.model.id &&
                        widget.selected?.source == item.source,
                    onTap: () {
                      Navigator.of(context).pop(item);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
      ],
    );
  }
}
