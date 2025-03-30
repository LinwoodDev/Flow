import 'package:flow/widgets/select.dart';
import 'package:flow_api/models/user/model.dart';
import 'package:flutter/material.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'dart:typed_data';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/model.dart';

import 'user.dart';

class UserSelectTile extends StatelessWidget {
  final String source;
  final Uint8List? value;
  final ValueChanged<SourcedModel<Uint8List>?> onChanged;

  const UserSelectTile({
    super.key,
    required this.source,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SelectTile(
      source: source,
      onChanged: onChanged,
      onModelFetch: (source, service, id) async => service.user?.getUser(id),
      title: AppLocalizations.of(context).user,
      leadingBuilder: (context, model) => PhosphorIcon(model?.model == null
          ? PhosphorIconsLight.users
          : PhosphorIconsFill.users),
      dialogBuilder: (context, sourcedModel) => UserDialog(
        source: sourcedModel?.source,
        user: sourcedModel?.model,
        create: sourcedModel?.model == null,
      ),
      selectBuilder: (context, model) => UserSelectDialog(
        selected: model?.toIdentifierModel(),
        source: source,
      ),
    );
  }
}

class UserSelectDialog extends StatelessWidget {
  final String? source;
  final SourcedModel<Uint8List>? selected;

  const UserSelectDialog({
    super.key,
    this.source,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SelectDialog(
      onFetch: (source, service, search, offset, limit) async =>
          service.user?.getUsers(
        offset: offset,
        limit: limit,
        search: search,
      ),
      onCreate: (source) => showDialog<SourcedModel<User>>(
        context: context,
        builder: (context) => UserDialog(
          source: source,
          user: null,
          create: true,
        ),
      ),
      title: AppLocalizations.of(context).user,
      selected: selected,
    );
  }
}
