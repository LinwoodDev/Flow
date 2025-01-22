import 'dart:typed_data';

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

class Uint8ListConverter extends SimpleMapper<Uint8List> {
  const Uint8ListConverter();

  @override
  Uint8List decode(Object value) {
    if (value is Uint8List) {
      return value;
    }
    if (value is List) {
      return Uint8List.fromList(value.cast<int>());
    }
    return Uint8List(0);
  }

  @override
  Object? encode(Uint8List self) {
    return self;
  }
}
