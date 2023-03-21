import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

abstract class DescriptiveModel {
  int get id;
  String get name;
  String get description;
}

@freezed
class SourcedModel<T> with _$SourcedModel<T> {
  const SourcedModel._();

  const factory SourcedModel(
    String source,
    T model,
  ) = _SourcedModel<T>;

  factory SourcedModel.fromEntry(MapEntry<String, T> entry) =>
      SourcedModel(entry.key, entry.value);
}
