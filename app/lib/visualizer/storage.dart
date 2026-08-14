import 'package:flow/api/storage/remote/model.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/helpers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension StorageVisualizer on RemoteStorage {
  String getLocalizedName(BuildContext context) => switch (this) {
    CalDavStorage() => 'CalDAV',
    ICalStorage() => 'iCal',
    DeviceCalendarStorage() => 'Device calendar',
    SiaStorage() => 'Sia',
    WebDavStorage() => 'WebDAV',
  };

  IconGetter get icon => switch (this) {
    CalDavStorage() => PhosphorIcons.globe,
    ICalStorage() => PhosphorIcons.calendar,
    DeviceCalendarStorage() => PhosphorIcons.deviceMobile,
    SiaStorage() => PhosphorIcons.cloud,
    WebDavStorage() => PhosphorIcons.fileText,
  };
}
