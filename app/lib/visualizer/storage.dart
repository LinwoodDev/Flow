import 'package:flow/api/storage/remote/model.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/helpers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension StorageVisualizer on RemoteStorage {
  String getLocalizedName(BuildContext context) => switch (this) {
    CalDavStorage() => 'CalDAV',
    ICalStorage() => 'iCal',
    DeviceCalendarStorage() => AppLocalizations.of(context).deviceCalendar,
    SiaStorage() => 'Sia',
    WebDavStorage() => 'WebDAV',
  };

  IconGetter get icon => switch (this) {
    CalDavStorage() => IconGetter(
      PhosphorIconsLight.globe,
      PhosphorIconsFill.globe,
    ),
    ICalStorage() => IconGetter(
      PhosphorIconsLight.calendar,
      PhosphorIconsFill.calendar,
    ),
    DeviceCalendarStorage() => IconGetter(
      PhosphorIconsLight.deviceMobile,
      PhosphorIconsFill.deviceMobile,
    ),
    SiaStorage() => IconGetter(
      PhosphorIconsLight.cloud,
      PhosphorIconsFill.cloud,
    ),
    WebDavStorage() => IconGetter(
      PhosphorIconsLight.fileText,
      PhosphorIconsFill.fileText,
    ),
  };
}
