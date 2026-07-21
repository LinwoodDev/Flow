import 'package:flow/api/storage/remote/model.dart';
import 'package:flutter/material.dart';

import 'remote.dart';

class CalDavSourceDialog extends StatelessWidget {
  const CalDavSourceDialog({super.key});

  @override
  Widget build(BuildContext context) => RemoteSourceDialog(
    title: 'CalDAV',
    storageBuilder: ({required url, required username}) =>
        CalDavStorage(url: url, username: username),
  );
}
