import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/pages/groups/select.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flow_api/services/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/group/model.dart';

import '../../cubits/flow.dart';
import 'group.dart';

class GroupsView<T extends DescriptiveModel> extends StatefulWidget {
  final T model;
  final String source;
  final ModelConnector<Group, T> connector;

  const GroupsView(
      {super.key,
      required this.source,
      required this.connector,
      required this.model});
  GroupsView.reversed(
      {super.key,
      required this.source,
      required ModelConnector<T, Group> connector,
      required this.model})
      : connector = ReversedModelConnector(connector);

  @override
  State<GroupsView<T>> createState() => _GroupsViewState();
}

class _GroupsViewState<T extends DescriptiveModel>
    extends State<GroupsView<T>> {
  late final SourcedPagingBloc<Group> _bloc;

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
  Widget build(BuildContext context) => Stack(
        children: [
          Column(
            children: [
              Flexible(
                child: PagedListView.source(
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
                          await showDialog<SourcedModel<Group>>(
                            context: context,
                            builder: (context) => GroupDialog(
                              source: widget.source,
                              group: item,
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
                  final group = await showDialog<SourcedModel<Group>>(
                    context: context,
                    builder: (context) => GroupSelectDialog(
                      source: widget.source,
                    ),
                  );
                  if (group != null) {
                    await widget.connector
                        .connect(widget.model.id!, group.model.id!);
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
