import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

abstract class DescriptiveModel {
  int get id;
  String get name;
  String get description;
}

@freezed
class ConnectedModel<A, B> with _$ConnectedModel<A, B> {
  const ConnectedModel._();

  const factory ConnectedModel(
    A source,
    B model,
  ) = _ConnectedModel<A, B>;

  factory ConnectedModel.fromEntry(MapEntry<A, B> entry) =>
      ConnectedModel(entry.key, entry.value);
}

typedef SourcedModel<T> = ConnectedModel<String, T>;
