import 'dart:convert';

import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';

part 'model.mapper.dart';

const kColorBlack = 0xFF000000;

enum ModelPermission { read, write, link, admin }

mixin IdentifiedModel {
  Uint8List? get id;

  String toDisplayString() {
    return base64Encode(id ?? []);
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

@MappableClass()
class ConnectedModel<A, B> with ConnectedModelMappable<A, B> {
  final A source;
  final B model;

  const ConnectedModel(
    this.source,
    this.model,
  );

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
  ConnectedModel<A, Uint8List>? toIdentifierModel() {
    final id = model?.id;
    if (id == null) return null;
    return ConnectedModel(source, id);
  }
}
