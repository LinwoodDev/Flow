// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class ConnectedModelMapper extends ClassMapperBase<ConnectedModel> {
  ConnectedModelMapper._();

  static ConnectedModelMapper? _instance;
  static ConnectedModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConnectedModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ConnectedModel';
  @override
  Function get typeFactory => <A, B>(f) => f<ConnectedModel<A, B>>();

  static dynamic _$source(ConnectedModel v) => v.source;
  static dynamic _arg$source<A, B>(f) => f<A>();
  static const Field<ConnectedModel, dynamic> _f$source =
      Field('source', _$source, arg: _arg$source);
  static dynamic _$model(ConnectedModel v) => v.model;
  static dynamic _arg$model<A, B>(f) => f<B>();
  static const Field<ConnectedModel, dynamic> _f$model =
      Field('model', _$model, arg: _arg$model);

  @override
  final MappableFields<ConnectedModel> fields = const {
    #source: _f$source,
    #model: _f$model,
  };

  static ConnectedModel<A, B> _instantiate<A, B>(DecodingData data) {
    return ConnectedModel(data.dec(_f$source), data.dec(_f$model));
  }

  @override
  final Function instantiate = _instantiate;

  static ConnectedModel<A, B> fromMap<A, B>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ConnectedModel<A, B>>(map);
  }

  static ConnectedModel<A, B> fromJson<A, B>(String json) {
    return ensureInitialized().decodeJson<ConnectedModel<A, B>>(json);
  }
}

mixin ConnectedModelMappable<A, B> {
  String toJson() {
    return ConnectedModelMapper.ensureInitialized()
        .encodeJson<ConnectedModel<A, B>>(this as ConnectedModel<A, B>);
  }

  Map<String, dynamic> toMap() {
    return ConnectedModelMapper.ensureInitialized()
        .encodeMap<ConnectedModel<A, B>>(this as ConnectedModel<A, B>);
  }

  ConnectedModelCopyWith<ConnectedModel<A, B>, ConnectedModel<A, B>,
          ConnectedModel<A, B>, A, B>
      get copyWith => _ConnectedModelCopyWithImpl<
          ConnectedModel<A, B>,
          ConnectedModel<A, B>,
          A,
          B>(this as ConnectedModel<A, B>, $identity, $identity);
  @override
  String toString() {
    return ConnectedModelMapper.ensureInitialized()
        .stringifyValue(this as ConnectedModel<A, B>);
  }

  @override
  bool operator ==(Object other) {
    return ConnectedModelMapper.ensureInitialized()
        .equalsValue(this as ConnectedModel<A, B>, other);
  }

  @override
  int get hashCode {
    return ConnectedModelMapper.ensureInitialized()
        .hashValue(this as ConnectedModel<A, B>);
  }
}

extension ConnectedModelValueCopy<$R, $Out, A, B>
    on ObjectCopyWith<$R, ConnectedModel<A, B>, $Out> {
  ConnectedModelCopyWith<$R, ConnectedModel<A, B>, $Out, A, B>
      get $asConnectedModel => $base.as(
          (v, t, t2) => _ConnectedModelCopyWithImpl<$R, $Out, A, B>(v, t, t2));
}

abstract class ConnectedModelCopyWith<$R, $In extends ConnectedModel<A, B>,
    $Out, A, B> implements ClassCopyWith<$R, $In, $Out> {
  $R call({A? source, B? model});
  ConnectedModelCopyWith<$R2, $In, $Out2, A, B> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ConnectedModelCopyWithImpl<$R, $Out, A, B>
    extends ClassCopyWithBase<$R, ConnectedModel<A, B>, $Out>
    implements ConnectedModelCopyWith<$R, ConnectedModel<A, B>, $Out, A, B> {
  _ConnectedModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ConnectedModel> $mapper =
      ConnectedModelMapper.ensureInitialized();
  @override
  $R call({Object? source = $none, Object? model = $none}) =>
      $apply(FieldCopyWithData({
        if (source != $none) #source: source,
        if (model != $none) #model: model
      }));
  @override
  ConnectedModel<A, B> $make(CopyWithData data) => ConnectedModel(
      data.get(#source, or: $value.source), data.get(#model, or: $value.model));

  @override
  ConnectedModelCopyWith<$R2, ConnectedModel<A, B>, $Out2, A, B>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ConnectedModelCopyWithImpl<$R2, $Out2, A, B>($value, $cast, t);
}
