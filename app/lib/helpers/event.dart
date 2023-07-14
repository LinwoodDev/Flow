import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flow_api/models/event/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension EventStatusHelper on EventStatus {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case EventStatus.confirmed:
        return AppLocalizations.of(context).confirmed;
      case EventStatus.draft:
        return AppLocalizations.of(context).draft;
      case EventStatus.cancelled:
        return AppLocalizations.of(context).cancelled;
    }
  }

  IconGetter get icon {
    switch (this) {
      case EventStatus.confirmed:
        return PhosphorIcons.checkCircle;
      case EventStatus.draft:
        return PhosphorIcons.fileDashed;
      case EventStatus.cancelled:
        return PhosphorIcons.xCircle;
    }
  }

  Color getColor() {
    switch (this) {
      case EventStatus.confirmed:
        return Colors.green;
      case EventStatus.draft:
        return Colors.orange;
      case EventStatus.cancelled:
        return Colors.red;
    }
  }
}
