import 'package:flutter/material.dart';
import 'package:shared/models/event/model.dart';
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

  IconData getIcon([bool filled = false]) {
    switch (this) {
      case EventStatus.confirmed:
        return filled
            ? Icons.check_circle
            : Icons.check_circle_outline_outlined;
      case EventStatus.draft:
        return filled ? Icons.drafts : Icons.drafts_outlined;
      case EventStatus.cancelled:
        return filled ? Icons.cancel : Icons.cancel_outlined;
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

extension DateTimeHelper on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime addYears(int years) {
    return DateTime(
        year + years, month, day, hour, minute, second, millisecond);
  }

  DateTime addDays(int days) {
    return DateTime(year, month, day + days, hour, minute, second, millisecond);
  }

  int get week {
    final date = DateTime(year, month, day);
    final firstDay = DateTime(date.year - 1, 12, 31);
    final days = date.difference(firstDay).inDays;
    return (days / 7).ceil();
  }

  DateTime get nextStartOfWeek {
    var date = DateTime(year, month, day);
    return date.addDays(7 - date.weekday + 1);
  }

  int getDaysInMonth() {
    return DateTime(year, month + 1, 0).day;
  }
}
