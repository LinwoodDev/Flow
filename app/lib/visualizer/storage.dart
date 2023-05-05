import 'package:flow/api/storage/remote/model.dart';
import 'package:flutter/material.dart';

extension StorageVisualizer on RemoteStorage {
  String getLocalizedName(BuildContext context) {
    return map(
        calDav: (_) => 'CalDAV',
        iCal: (_) => 'iCal',
        sia: (_) => 'Sia',
        webDav: (_) => 'WebDAV');
  }

  IconData getIcon() {
    return map(
      calDav: (_) => Icons.calendar_today_outlined,
      iCal: (_) => Icons.view_agenda_outlined,
      sia: (_) => Icons.cloud,
      webDav: (_) => Icons.folder_outlined,
    );
  }
}
