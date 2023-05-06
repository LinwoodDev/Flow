import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../cubits/settings.dart';

extension SyncStatusVisualizer on SyncStatus? {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case SyncStatus.syncing:
        return AppLocalizations.of(context).syncing;
      case SyncStatus.synced:
        return AppLocalizations.of(context).synced;
      case SyncStatus.error:
        return AppLocalizations.of(context).error;
      default:
        return AppLocalizations.of(context).loading;
    }
  }

  IconGetter get icon {
    switch (this) {
      case SyncStatus.syncing:
        return PhosphorIcons.arrowClockwise;
      case SyncStatus.synced:
        return PhosphorIcons.check;
      default:
        return PhosphorIcons.warningCircle;
    }
  }
}

extension SyncModeVisualizer on SyncMode {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case SyncMode.always:
        return AppLocalizations.of(context).always;
      case SyncMode.noMobile:
        return AppLocalizations.of(context).noMobile;
      case SyncMode.manual:
        return AppLocalizations.of(context).manual;
    }
  }

  IconGetter get icon {
    switch (this) {
      case SyncMode.always:
        return PhosphorIcons.wifiHigh;
      case SyncMode.noMobile:
        return PhosphorIcons.deviceMobile;
      case SyncMode.manual:
        return PhosphorIcons.wifiX;
    }
  }
}
