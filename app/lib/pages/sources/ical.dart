import 'package:flow/api/storage/remote/model.dart';
import 'package:material_ui/material_ui.dart';

import 'remote.dart';

class ICalSourceDialog extends StatelessWidget {
  const ICalSourceDialog({super.key});

  @override
  Widget build(BuildContext context) => RemoteSourceDialog(
    title: 'iCal',
    storageBuilder: ({required name, required url, required username}) =>
        ICalStorage(name: name, url: url, username: username),
  );
}
