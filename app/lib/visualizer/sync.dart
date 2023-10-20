import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        SyncStatus.syncing => PhosphorIcons.arrowClockwise,
        SyncStatus.synced => PhosphorIcons.check,
        _ => PhosphorIcons.warningCircle,
      };
}

extension SyncModeVisualizer on SyncMode {
  String getLocalizedName(BuildContext context) => switch (this) {
        SyncMode.always => AppLocalizations.of(context).always,
        SyncMode.noMobile => AppLocalizations.of(context).noMobile,
        SyncMode.manual => AppLocalizations.of(context).manual,
      };

  IconGetter get icon => switch (this) {
        SyncMode.always => PhosphorIcons.wifiHigh,
        SyncMode.noMobile => PhosphorIcons.deviceMobile,
        SyncMode.manual => PhosphorIcons.wifiX,
      };
}
