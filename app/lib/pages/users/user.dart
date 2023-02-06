import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared/models/group/model.dart';
import 'package:shared/models/user/model.dart';

import '../../cubits/flow.dart';
import '../groups/select.dart';

class UserDialog extends StatelessWidget {
  final String? source;
  final User? user;
  const UserDialog({super.key, this.source, this.user});

  @override
  Widget build(BuildContext context) {
    var user = this.user ?? const User();
    var currentSource = source ?? '';
    return AlertDialog(
      title: Text(source == null
          ? AppLocalizations.of(context).createUser
          : AppLocalizations.of(context).editUser),
      content: SizedBox(
        width: 500,
        child: Column(children: [
          if (source == null) ...[
            DropdownButtonFormField<String>(
              value: source,
              items: context
                  .read<FlowCubit>()
                  .getCurrentSources()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.isEmpty
                      ? AppLocalizations.of(context).local
                      : value),
                );
              }).toList(),
              onChanged: (String? value) {
                currentSource = value ?? '';
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).source,
                icon: const Icon(Icons.storage_outlined),
                border: const OutlineInputBorder(),
              ),
            ),
          ] else ...[
            StatefulBuilder(
                builder: (context, setState) => ListTile(
                      leading: const Icon(Icons.folder_outlined),
                      title: Text(AppLocalizations.of(context).group),
                      onTap: () async {
                        final groupId = await showDialog<MapEntry<String, int>>(
                          context: context,
                          builder: (context) => GroupSelectDialog(
                            selected: user.groupId == null
                                ? null
                                : MapEntry(source!, user.groupId!),
                            source: source!,
                          ),
                        );
                        if (groupId != null) {
                          setState(() {
                            user = user.copyWith(groupId: groupId.value);
                          });
                        }
                      },
                      subtitle: user.groupId == null
                          ? null
                          : FutureBuilder<Group?>(
                              future: Future.value(context
                                  .read<FlowCubit>()
                                  .getSource(source!)
                                  .group
                                  ?.getGroup(user.groupId ?? -1)),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data!.name);
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else {
                                  return const CircularProgressIndicator();
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
              context
                  .read<FlowCubit>()
                  .getSource(currentSource)
                  .user
                  ?.createUser(user);
            } else {
              context
                  .read<FlowCubit>()
                  .getSource(source!)
                  .user
                  ?.updateUser(user);
            }
            Navigator.of(context).pop(user);
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
