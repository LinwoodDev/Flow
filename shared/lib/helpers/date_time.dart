extension DateTimeHelper on DateTime {
  int get secondsSinceEpoch {
    var ms = millisecondsSinceEpoch;
    return (ms / 1000).round();
  }

  DateTime onlyDate() {
    return DateTime(year, month, day);
  }

  static DateTime fromSecondsSinceEpoch(int seconds) {
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
}
