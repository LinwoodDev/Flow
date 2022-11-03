import 'package:flutter/material.dart';
import 'package:shared/models/event/model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension EventStatusHelper on EventStatus {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case EventStatus.confirmed:
        return AppLocalizations.of(context)!.confirmed;
      case EventStatus.draft:
        return AppLocalizations.of(context)!.draft;
      case EventStatus.cancelled:
        return AppLocalizations.of(context)!.cancelled;
    }
  }

  IconData getIcon() {
    switch (this) {
      case EventStatus.confirmed:
        return Icons.check_circle_outline_outlined;
      case EventStatus.draft:
        return Icons.drafts_outlined;
      case EventStatus.cancelled:
        return Icons.cancel_outlined;
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
