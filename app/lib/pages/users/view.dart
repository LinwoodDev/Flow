import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/pages/users/select.dart';
import 'package:flow/widgets/paging/list.dart';
import 'package:flow_api/services/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/user/model.dart';

import '../../cubits/flow.dart';
import 'user.dart';

class UsersView<T extends DescriptiveModel> extends StatefulWidget {
  final T model;
  final String source;
  final ModelConnector<User, T> connector;

  const UsersView(
      {super.key,
      required this.source,
      required this.connector,
      required this.model});
  UsersView.reversed(
      {super.key,
      required this.source,
      required ModelConnector<T, User> connector,
      required this.model})
      : connector = ReversedModelConnector(connector);

  @override
  State<UsersView<T>> createState() => _UsersViewState();
}

class _UsersViewState<T extends DescriptiveModel> extends State<UsersView<T>> {
  late final SourcedPagingBloc<User> _bloc;

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
                        widget.connector.disconnect(widget.model.id!, item.id!);
                        _bloc.removeSourced(item);
                      },
                      child: ListTile(
                        title: Text(item.name),
                        onTap: () async {
                          await showDialog<SourcedModel<User>>(
                            context: context,
                            builder: (context) => UserDialog(
                              source: widget.source,
                              user: item,
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
                  final user = await showDialog<SourcedModel<User>>(
                    context: context,
                    builder: (context) => UserSelectDialog(
                      source: widget.source,
                    ),
                  );
                  if (user != null) {
                    await widget.connector
                        .connect(widget.model.id!, user.model.id!);
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
