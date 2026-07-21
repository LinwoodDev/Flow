enum DateRangeValidationError { endBeforeStart, repeatUntilBeforeStart }

Uri? parseRemoteUri(String value) {
  final uri = Uri.tryParse(value.trim());
  if (uri == null ||
      !uri.hasAuthority ||
      uri.host.isEmpty ||
      (uri.scheme != 'http' && uri.scheme != 'https')) {
    return null;
  }
  return uri;
}

DateRangeValidationError? validateDateRange({
  required DateTime? start,
  required DateTime? end,
  DateTime? repeatUntil,
}) {
  if (start != null && end != null && end.isBefore(start)) {
    return DateRangeValidationError.endBeforeStart;
  }
  if (start != null && repeatUntil != null && repeatUntil.isBefore(start)) {
    return DateRangeValidationError.repeatUntilBeforeStart;
  }
  return null;
}

bool isValidAlarmDate({
  required DateTime date,
  required bool isActive,
  required DateTime now,
}) => !isActive || date.isAfter(now);
