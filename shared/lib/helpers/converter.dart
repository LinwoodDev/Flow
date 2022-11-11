import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/helpers/date_time.dart';

class DateTimeConverter extends JsonConverter<DateTime, int> {
  const DateTimeConverter();

  @override
  DateTime fromJson(int json) {
    return DateTimeHelper.fromSecondsSinceEpoch(json);
  }

  @override
  int toJson(DateTime object) {
    return object.secondsSinceEpoch;
  }
}

class Uint8ListConverter extends JsonConverter<Uint8List, List<int>> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(List<int> json) {
    return Uint8List.fromList(json);
  }

  @override
  List<int> toJson(Uint8List object) {
    return object.toList();
  }
}
