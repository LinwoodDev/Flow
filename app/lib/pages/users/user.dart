import 'package:flow/widgets/markdown_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/user/model.dart';
import 'package:flow_api/models/user/service.dart';

import '../../cubits/flow.dart';
import '../../widgets/source_dropdown.dart';
import '../groups/select.dart';

class UserDialog extends StatelessWidget {
  final String? source;
  final User? user;
  final bool create;
  const UserDialog({super.key, this.source, this.user, this.create = false});

  @override
  Widget build(BuildContext context) {
    final create = this.create || user == null || source == null;
    var currentUser = user ?? const User();
    var currentSource = source ?? '';
    var currentService =
        context.read<FlowCubit>().getService(currentSource).user;
    return AlertDialog(
      title: Text(source == null
          ? AppLocalizations.of(context).createUser
          : AppLocalizations.of(context).editUser),
      content: SizedBox(
        width: 500,
        child: Column(children: [
          if (source == null) ...[
            SourceDropdown<UserService>(
              value: currentSource,
              buildService: (e) => e.user,
              onChanged: (connected) {
                currentSource = connected?.source ?? '';
                currentService = connected?.model;
              },
            ),
          ],
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).name,
              filled: true,
              icon: const PhosphorIcon(PhosphorIconsLight.fileText),
            ),
            initialValue: currentUser.name,
            onChanged: (value) {
              currentUser = currentUser.copyWith(name: value);
            },
          ),
          const SizedBox(height: 16),
          MarkdownField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).description,
              border: const OutlineInputBorder(),
              icon: const PhosphorIcon(PhosphorIconsLight.fileText),
            ),
            value: currentUser.description,
            onChanged: (value) {
              currentUser = currentUser.copyWith(description: value);
            },
          ),
          if (!create) ...[
            const SizedBox(height: 16),
            GroupSelectTile(
              value: currentUser.groupId,
              source: currentSource,
              onChanged: (value) {
                currentUser = currentUser.copyWith(groupId: value?.model);
              },
            ),
          ],
        ]),
      ),
      scrollable: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () async {
            if (source == null) {
              final created = await currentService?.createUser(currentUser);
              if (created == null) {
                return;
              }
              currentUser = created;
            } else {
              await currentService?.updateUser(currentUser);
            }
            if (context.mounted) {
              Navigator.of(context).pop(currentUser);
            }
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
