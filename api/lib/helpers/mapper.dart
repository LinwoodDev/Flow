import 'package:dart_leap/dart_leap.dart';
import 'package:dart_mappable/dart_mappable.dart';

class SecondsDateTimeMapper extends SimpleMapper<DateTime> {
  const SecondsDateTimeMapper();

  @override
  DateTime decode(Object value) {
    if (value is int) {
      return DateTimeHelper.fromSecondsSinceEpoch(value);
    }
    return DateTime.now();
  }

  @override
  Object? encode(DateTime? self) {
    return self?.secondsSinceEpoch;
  }
}
