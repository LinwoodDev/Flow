import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flow_api/services/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/group/model.dart';
import 'package:flow_api/models/group/service.dart';

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
  late final GroupService? _groupService;

  late final SourcedPagingBloc<Group> _bloc;

  @override
  void initState() {
    final cubit = context.read<FlowCubit>();
    final service = cubit.getService(widget.source);
    _groupService = service.group;
    _bloc = SourcedPagingBloc.simple(
      cubit: cubit,
      fetch: (source, service, offset, limit) => widget.connector
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
                child: PagedListView.simple(
                  bloc: _bloc,
                  itemBuilder: (context, item, index) {
                    final group = item.model;
                    return Dismissible(
                      key: ValueKey(group.id),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        _groupService?.deleteGroup(group.id!);
                        _bloc.remove(item);
                      },
                      child: ListTile(
                        title: Text(group.name),
                        onTap: () async {
                          await showDialog<SourcedModel<Group>>(
                            context: context,
                            builder: (context) => GroupDialog(
                              source: widget.source,
                              group: group,
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
                label: Text(AppLocalizations.of(context).create),
                icon: const PhosphorIcon(PhosphorIconsLight.plus),
                onPressed: () async {
                  final group = await showDialog<SourcedModel<Group>>(
                    context: context,
                    builder: (context) => GroupDialog(
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
