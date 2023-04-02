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

typedef SourcedConnectedModel<A, B> = SourcedModel<ConnectedModel<A, B>>;

extension SourcedConnectedModelExtension<A, B> on SourcedConnectedModel<A, B> {
  A get main => model.source;
  B get sub => model.model;

  SourcedModel<A> get mainSourced => SourcedModel(source, main);
  SourcedModel<B> get subSourced => SourcedModel(source, sub);
}

extension SourcedConnectedModelNullableExtension<A, B>
    on SourcedConnectedModel<A?, B?> {
  SourcedModel<A>? get mainSourcedOrNull =>
      main == null ? null : SourcedModel(source, main as A);
  SourcedModel<B>? get subSourcedOrNull =>
      sub == null ? null : SourcedModel(source, sub as B);
}
