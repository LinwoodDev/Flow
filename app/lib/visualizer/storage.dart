import 'package:flow/api/storage/remote/model.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/helpers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension StorageVisualizer on RemoteStorage {
  String getLocalizedName(BuildContext context) {
    return map(
        calDav: (_) => 'CalDAV',
        iCal: (_) => 'iCal',
        sia: (_) => 'Sia',
        webDav: (_) => 'WebDAV');
  }

  IconGetter get icon {
    return map(
      calDav: (_) => PhosphorIcons.globe,
      iCal: (_) => PhosphorIcons.calendar,
      sia: (_) => PhosphorIcons.cloud,
      webDav: (_) => PhosphorIcons.fileText,
    );
  }
}
