import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/pages/resources/resource.dart';
import 'package:flow_api/models/resource/model.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import '../../cubits/flow.dart';
import '../../widgets/markdown_field.dart';
import '../calendar/filter.dart';

class ResourceTile extends StatelessWidget {
  const ResourceTile({
    super.key,
    required this.source,
    required this.resource,
    required this.flowCubit,
    required this.bloc,
  });

  final FlowCubit flowCubit;
  final Resource resource;
  final String source;
  final SourcedPagingBloc<Resource> bloc;

  @override
  Widget build(BuildContext context) {
    return ContextRegion(
      menuChildren: [
        (
          PhosphorIconsLight.calendar,
          AppLocalizations.of(context).events,
          _openEvents,
        ),
        (
          PhosphorIconsLight.trash,
          AppLocalizations.of(context).delete,
          _deleteResource,
        ),
      ]
          .map((e) => MenuItemButton(
                leadingIcon: PhosphorIcon(e.$1),
                child: Text(e.$2),
                onPressed: () => e.$3(context),
              ))
          .toList(),
      builder: (context, button, controller) => ListTile(
        title: Text(resource.name),
        subtitle: MarkdownText(resource.description),
        onTap: () => _editResource(context),
        trailing: button,
      ),
    );
  }

  void _deleteResource(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).deleteResource(resource.name)),
        content: Text(AppLocalizations.of(context)
            .deleteResourceDescription(resource.name)),
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
              await flowCubit
                  .getService(source)
                  .resource
                  ?.deleteResource(resource.id!);
              bloc.remove(SourcedModel(
                source,
                resource,
              ));
              bloc.refresh();
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
        source: source,
      ),
    );
  }

  void _editResource(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ResourceDialog(
        resource: resource,
        source: source,
      ),
    ).then((value) => bloc.refresh());
  }
}
