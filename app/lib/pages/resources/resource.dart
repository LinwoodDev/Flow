import 'package:flow/pages/groups/view.dart';
import 'package:flow/pages/users/view.dart';
import 'package:flow/widgets/markdown_field.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/models/resource/model.dart';
import 'package:flow_api/models/resource/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/flow.dart';
import '../../widgets/source_dropdown.dart';

class ResourceDialog extends StatelessWidget {
  final String? source;
  final Resource? resource;
  final bool create;

  const ResourceDialog({
    super.key,
    this.source,
    this.resource,
    this.create = false,
  });

  @override
  Widget build(BuildContext context) {
    final create = this.create || resource == null || source == null;
    final cubit = context.read<FlowCubit>();
    var currentResource = resource ?? const Resource();
    var currentSource = source ?? '';
    var currentService = cubit.getService(currentSource).resource;
    final userConnector = cubit.getService(currentSource).userResource;
    final groupConnector = cubit.getService(currentSource).groupResource;
    final tabs = !create && userConnector != null && groupConnector != null;
    return ResponsiveAlertDialog(
      title: Text(create
          ? AppLocalizations.of(context).createResource
          : AppLocalizations.of(context).editResource),
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
      content: DefaultTabController(
        length: tabs ? 3 : 1,
        child: Column(
          spacing: 8,
          children: [
            if (tabs)
              TabBar(
                  tabs: [
                (
                  PhosphorIconsLight.faders,
                  AppLocalizations.of(context).general
                ),
                (PhosphorIconsLight.user, AppLocalizations.of(context).users),
                (
                  PhosphorIconsLight.usersThree,
                  AppLocalizations.of(context).group
                ),
              ]
                      .map((e) => HorizontalTab(
                            icon: PhosphorIcon(e.$1),
                            label: Text(e.$2),
                          ))
                      .toList()),
            Flexible(
              child: TabBarView(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: ListView(shrinkWrap: true, children: [
                      if (source == null) ...[
                        SourceDropdown<ResourceService>(
                          value: currentSource,
                          buildService: (e) => e.resource,
                          onChanged: (connected) {
                            currentSource = connected?.source ?? '';
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).name,
                          filled: true,
                          icon: const PhosphorIcon(PhosphorIconsLight.fileText),
                        ),
                        initialValue: currentResource.name,
                        onChanged: (value) {
                          currentResource =
                              currentResource.copyWith(name: value);
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).location,
                          filled: true,
                          icon: const PhosphorIcon(PhosphorIconsLight.mapPin),
                        ),
                        initialValue: currentResource.address,
                        onChanged: (value) {
                          currentResource =
                              currentResource.copyWith(address: value);
                        },
                      ),
                      const SizedBox(height: 16),
                      MarkdownField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).description,
                          border: const OutlineInputBorder(),
                          icon: const PhosphorIcon(PhosphorIconsLight.fileText),
                        ),
                        value: currentResource.description,
                        onChanged: (value) {
                          currentResource =
                              currentResource.copyWith(description: value);
                        },
                      )
                    ]),
                  ),
                  if (tabs) ...[
                    UsersView.reversed(
                      model: currentResource,
                      connector: userConnector,
                      source: currentSource,
                    ),
                    GroupsView.reversed(
                      model: currentResource,
                      connector: groupConnector,
                      source: currentSource,
                    ),
                  ],
                ],
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
        ElevatedButton(
          onPressed: () async {
            if (create) {
              final created =
                  await currentService?.createResource(currentResource);
              if (created == null) {
                return;
              }
              currentResource = created;
            } else {
              await currentService?.updateResource(currentResource);
            }
            if (context.mounted) {
              Navigator.of(context)
                  .pop(SourcedModel(currentSource, currentResource));
            }
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
