import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lib5/lib5.dart';

part 'model.freezed.dart';

const kColorBlack = 0xFF000000;

mixin IdentifiedModel {
  Multihash? get id;

  String toDisplayString() {
    return id?.toBase64Url() ?? '';
  }
}

mixin NamedModel on IdentifiedModel {
  String get name;

  @override
  String toDisplayString() {
    return name;
  }
}

mixin DescriptiveModel on NamedModel {
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

extension SourcedDisplayModel on SourcedModel<IdentifiedModel> {
  String toDisplayString() => '${model.toDisplayString()}@$source';
}

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

extension ConnectedModelIdentifier<A, B extends IdentifiedModel?>
    on ConnectedModel<A, B> {
  ConnectedModel<A, Multihash>? toIdentifierModel() {
    final id = model?.id;
    if (id == null) return null;
    return ConnectedModel(source, id);
  }
}
