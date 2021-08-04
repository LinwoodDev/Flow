import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class JsonObject extends Equatable {
  const JsonObject();

  JsonObject.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  JsonObject copyWith();
}
