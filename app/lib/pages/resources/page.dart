import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/pages/resources/resource.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flow_api/models/resource/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/flow.dart';
import 'tile.dart';

class ResourcesPage extends StatefulWidget {
  const ResourcesPage({
    super.key,
  });

  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context).resources,
      actions: [
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
          onPressed: () => showSearch(
              context: context, delegate: _ResourcesSearchDelegate()),
        ),
      ],
      body: const ResourcesBodyView(),
    );
  }
}

class _ResourcesSearchDelegate extends SearchDelegate {
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
    return ResourcesBodyView(
      search: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class ResourcesBodyView extends StatefulWidget {
  final String search;

  const ResourcesBodyView({
    super.key,
    this.search = '',
  });

  @override
  State<ResourcesBodyView> createState() => _ResourcesBodyViewState();
}

class _ResourcesBodyViewState extends State<ResourcesBodyView> {
  late final FlowCubit _flowCubit;
  late final SourcedPagingBloc<Resource> _bloc;

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _bloc = SourcedPagingBloc.item(
        cubit: _flowCubit,
        fetch: (source, service, offset, limit) async =>
            service.resource?.getResources(offset: offset, limit: limit));
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ResourcesBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search != widget.search) {
      _bloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedListView.item(
        bloc: _bloc,
        itemBuilder: (ctx, item, index) => Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Dismissible(
              key: ValueKey('${item.model.id}@${item.source}'),
              onDismissed: (direction) async {
                await _flowCubit
                    .getService(item.source)
                    .resource
                    ?.deleteResource(item.model.id!);
                _bloc.remove(item);
              },
              background: Container(
                color: Colors.red,
              ),
              child: ResourceTile(
                flowCubit: _flowCubit,
                bloc: _bloc,
                source: item.source,
                resource: item.model,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
                context: context, builder: (context) => const ResourceDialog())
            .then((_) => _bloc.refresh()),
        label: Text(AppLocalizations.of(context).create),
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
      ),
    );
  }
}
