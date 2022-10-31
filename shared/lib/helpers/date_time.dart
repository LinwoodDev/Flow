extension DateTimeHelper on DateTime {
  int get secondsSinceEpoch {
    var ms = millisecondsSinceEpoch;
    return (ms / 1000).round();
  }

  static DateTime fromSecondsSinceEpoch(int seconds) {
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
}
