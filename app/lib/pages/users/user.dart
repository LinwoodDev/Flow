import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/model.dart';
import 'package:shared/models/user/model.dart';
import 'package:shared/models/user/service.dart';

import '../../cubits/flow.dart';
import '../../widgets/source_dropdown.dart';
import '../groups/select.dart';

class UserDialog extends StatelessWidget {
  final String? source;
  final User? user;
  const UserDialog({super.key, this.source, this.user});

  @override
  Widget build(BuildContext context) {
    var user = this.user ?? const User();
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
          ] else ...[
            StatefulBuilder(
                builder: (context, setState) => ListTile(
                      leading: const Icon(Icons.folder_outlined),
                      title: Text(AppLocalizations.of(context).group),
                      onTap: () async {
                        final sourceGroup =
                            await showDialog<SourcedModel<Group>>(
                          context: context,
                          builder: (context) => GroupSelectDialog(
                            selected: user.groupId == null
                                ? null
                                : SourcedModel(source!, user.groupId!),
                            source: source!,
                          ),
                        );
                        if (sourceGroup != null) {
                          setState(() {
                            user = user.copyWith(groupId: sourceGroup.model.id);
                          });
                        }
                      },
                      subtitle: user.groupId == null
                          ? null
                          : FutureBuilder<Group?>(
                              future: Future.value(context
                                  .read<FlowCubit>()
                                  .getService(source!)
                                  .group
                                  ?.getGroup(user.groupId!)),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data!.name);
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return Text(AppLocalizations.of(context)
                                      .notSupported);
                                }
                              },
                            ),
                    )),
          ],
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).name,
              filled: true,
              icon: const Icon(Icons.folder_outlined),
            ),
            initialValue: user.name,
            onChanged: (value) {
              user = user.copyWith(name: value);
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).description,
              border: const OutlineInputBorder(),
              icon: const Icon(Icons.description_outlined),
            ),
            minLines: 3,
            maxLines: 5,
            initialValue: user.description,
            onChanged: (value) {
              user = user.copyWith(description: value);
            },
          )
        ]),
      ),
      scrollable: true,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (source == null) {
              currentService?.createUser(user);
            } else {
              currentService?.updateUser(user);
            }
            Navigator.of(context).pop(user);
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
