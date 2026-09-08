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

/// Separates URL user-info from the address before it is stored or displayed.
({Uri url, String username, String password})? parseRemoteCredentials(
  String value,
) {
  final uri = parseRemoteUri(value);
  if (uri == null || uri.userInfo.isEmpty) return null;
  final separator = uri.userInfo.indexOf(':');
  try {
    return (
      url: uri.replace(userInfo: ''),
      username: Uri.decodeComponent(
        separator < 0 ? uri.userInfo : uri.userInfo.substring(0, separator),
      ),
      password: separator < 0
          ? ''
          : Uri.decodeComponent(uri.userInfo.substring(separator + 1)),
    );
  } on FormatException {
    return null;
  }
}
