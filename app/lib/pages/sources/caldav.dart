import 'package:flow/api/storage/remote/model.dart';
import 'package:material_ui/material_ui.dart';

import 'remote.dart';

class CalDavSourceDialog extends StatelessWidget {
  const CalDavSourceDialog({super.key});

  @override
  Widget build(BuildContext context) => RemoteSourceDialog(
    title: 'CalDAV',
    storageBuilder: ({required name, required url, required username}) =>
        CalDavStorage(name: name, url: url, username: username),
  );
}
