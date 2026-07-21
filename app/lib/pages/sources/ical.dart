import 'package:flow/api/storage/remote/model.dart';
import 'package:flutter/material.dart';

import 'remote.dart';

class ICalSourceDialog extends StatelessWidget {
  const ICalSourceDialog({super.key});

  @override
  Widget build(BuildContext context) => RemoteSourceDialog(
    title: 'iCal',
    storageBuilder: ({required url, required username}) =>
        ICalStorage(url: url, username: username),
  );
}
