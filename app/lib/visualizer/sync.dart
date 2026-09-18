import 'package:material_ui/material_ui.dart';
import 'package:flow/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../cubits/settings.dart';

extension SyncStatusVisualizer on SyncStatus? {
  String getLocalizedName(BuildContext context) => switch (this) {
    SyncStatus.syncing => AppLocalizations.of(context).syncing,
    SyncStatus.synced => AppLocalizations.of(context).synced,
    SyncStatus.error => AppLocalizations.of(context).error,
    _ => AppLocalizations.of(context).loading,
  };

  IconGetter get icon => switch (this) {
    SyncStatus.syncing => IconGetter(
      PhosphorIconsLight.arrowClockwise,
      PhosphorIconsFill.arrowClockwise,
    ),
    SyncStatus.synced => IconGetter(
      PhosphorIconsLight.check,
      PhosphorIconsFill.check,
    ),
    _ => IconGetter(
      PhosphorIconsLight.warningCircle,
      PhosphorIconsFill.warningCircle,
    ),
  };
}

extension SyncModeVisualizer on SyncMode {
  String getLocalizedName(BuildContext context) => switch (this) {
    SyncMode.always => AppLocalizations.of(context).always,
    SyncMode.noMobile => AppLocalizations.of(context).noMobile,
    SyncMode.manual => AppLocalizations.of(context).manual,
  };

  IconGetter get icon => switch (this) {
    SyncMode.always => IconGetter(
      PhosphorIconsLight.wifiHigh,
      PhosphorIconsFill.wifiHigh,
    ),
    SyncMode.noMobile => IconGetter(
      PhosphorIconsLight.deviceMobile,
      PhosphorIconsFill.deviceMobile,
    ),
    SyncMode.manual => IconGetter(
      PhosphorIconsLight.wifiX,
      PhosphorIconsFill.wifiX,
    ),
  };
}
