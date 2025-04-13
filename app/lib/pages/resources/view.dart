import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/pages/resources/select.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/resource/model.dart';
import 'package:flow_api/models/resource/service.dart';

import '../../cubits/flow.dart';
import 'resource.dart';

class ResourcesView<T extends DescriptiveModel> extends StatefulWidget {
  final T model;
  final String source;
  final ResourceConnector<T> connector;

  const ResourcesView(
      {super.key,
      required this.source,
      required this.connector,
      required this.model});

  @override
  State<ResourcesView<T>> createState() => _ResourcesViewState();
}

class _ResourcesViewState<T extends DescriptiveModel>
    extends State<ResourcesView<T>> {
  late final SourcedPagingBloc<Resource> _bloc;

  @override
  void initState() {
    final cubit = context.read<FlowCubit>();
    _bloc = SourcedPagingBloc.source(
      cubit: cubit,
      source: widget.source,
      fetch: (service, offset, limit) => widget.connector
          .getItems(widget.model.id!, offset: offset, limit: limit),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      Stack(
        children: [
          Column(
            children: [
              Flexible(
                child: PagedListView<Resource>.source(
                  bloc: _bloc,
                  itemBuilder: (context, item, index) {
                    return Dismissible(
                      key: ValueKey(item.id),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        widget.connector.disconnect(
                          widget.model.id!,
                          item.id!,
                        );
                        _bloc.removeSourced(item);
                      },
                      child: ListTile(
                        title: Text(item.name),
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => ResourceDialog(
                              source: widget.source,
                              resource: item,
                            ),
                          );
                          _bloc.refresh();
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton.extended(
                label: Text(AppLocalizations.of(context).link),
                icon: const PhosphorIcon(PhosphorIconsLight.link),
                onPressed: () async {
                  final resource = await showDialog<SourcedModel<Resource>>(
                    context: context,
                    builder: (context) => ResourceSelectDialog(
                      source: widget.source,
                    ),
                  );
                  if (resource != null) {
                    await widget.connector
                        .connect(widget.model.id!, resource.model.id!);
                  }
                  _bloc.refresh();
                },
              ),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
