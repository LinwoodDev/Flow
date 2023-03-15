import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  IconData getIcon() {
    switch (this) {
      case SyncStatus.syncing:
        return Icons.sync_outlined;
      case SyncStatus.synced:
        return Icons.check_circle_outline;
      case SyncStatus.error:
        return Icons.error_outline;
      default:
        return Icons.sync_problem_outlined;
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

  IconData getIcon() {
    switch (this) {
      case SyncMode.always:
        return Icons.wifi_outlined;
      case SyncMode.noMobile:
        return Icons.wifi_tethering_off_outlined;
      case SyncMode.manual:
        return Icons.sync_disabled_outlined;
    }
  }
}
