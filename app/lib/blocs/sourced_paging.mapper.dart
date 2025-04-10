// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'sourced_paging.dart';

class SourcedPagingSuccessMapper extends ClassMapperBase<SourcedPagingSuccess> {
  SourcedPagingSuccessMapper._();

  static SourcedPagingSuccessMapper? _instance;
  static SourcedPagingSuccessMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SourcedPagingSuccessMapper._());
      ConnectedModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SourcedPagingSuccess';
  @override
  Function get typeFactory => <T>(f) => f<SourcedPagingSuccess<T>>();

  static List<ConnectedModel<String, dynamic>> _$items(
          SourcedPagingSuccess v) =>
      v.items;
  static dynamic _arg$items<T>(f) => f<List<ConnectedModel<String, T>>>();
  static const Field<SourcedPagingSuccess,
          List<ConnectedModel<String, dynamic>>> _f$items =
      Field('items', _$items, opt: true, def: const [], arg: _arg$items);
  static ConnectedModel<String, int> _$currentPageKey(SourcedPagingSuccess v) =>
      v.currentPageKey;
  static const Field<SourcedPagingSuccess, ConnectedModel<String, int>>
      _f$currentPageKey = Field('currentPageKey', _$currentPageKey);
  static bool _$hasReachedMax(SourcedPagingSuccess v) => v.hasReachedMax;
  static const Field<SourcedPagingSuccess, bool> _f$hasReachedMax =
      Field('hasReachedMax', _$hasReachedMax, opt: true, def: false);

  @override
  final MappableFields<SourcedPagingSuccess> fields = const {
    #items: _f$items,
    #currentPageKey: _f$currentPageKey,
    #hasReachedMax: _f$hasReachedMax,
  };

  static SourcedPagingSuccess<T> _instantiate<T>(DecodingData data) {
    return SourcedPagingSuccess(
        items: data.dec(_f$items),
        currentPageKey: data.dec(_f$currentPageKey),
        hasReachedMax: data.dec(_f$hasReachedMax));
  }

  @override
  final Function instantiate = _instantiate;
}

mixin SourcedPagingSuccessMappable<T> {
  SourcedPagingSuccessCopyWith<SourcedPagingSuccess<T>, SourcedPagingSuccess<T>,
          SourcedPagingSuccess<T>, T>
      get copyWith => _SourcedPagingSuccessCopyWithImpl<
          SourcedPagingSuccess<T>,
          SourcedPagingSuccess<T>,
          T>(this as SourcedPagingSuccess<T>, $identity, $identity);
  @override
  String toString() {
    return SourcedPagingSuccessMapper.ensureInitialized()
        .stringifyValue(this as SourcedPagingSuccess<T>);
  }

  @override
  bool operator ==(Object other) {
    return SourcedPagingSuccessMapper.ensureInitialized()
        .equalsValue(this as SourcedPagingSuccess<T>, other);
  }

  @override
  int get hashCode {
    return SourcedPagingSuccessMapper.ensureInitialized()
        .hashValue(this as SourcedPagingSuccess<T>);
  }
}

extension SourcedPagingSuccessValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, SourcedPagingSuccess<T>, $Out> {
  SourcedPagingSuccessCopyWith<$R, SourcedPagingSuccess<T>, $Out, T>
      get $asSourcedPagingSuccess => $base.as((v, t, t2) =>
          _SourcedPagingSuccessCopyWithImpl<$R, $Out, T>(v, t, t2));
}

abstract class SourcedPagingSuccessCopyWith<
    $R,
    $In extends SourcedPagingSuccess<T>,
    $Out,
    T> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      ConnectedModel<String, T>,
      ConnectedModelCopyWith<$R, ConnectedModel<String, T>,
          ConnectedModel<String, T>, String, T>> get items;
  ConnectedModelCopyWith<$R, ConnectedModel<String, int>,
      ConnectedModel<String, int>, String, int> get currentPageKey;
  $R call(
      {List<ConnectedModel<String, T>>? items,
      ConnectedModel<String, int>? currentPageKey,
      bool? hasReachedMax});
  SourcedPagingSuccessCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SourcedPagingSuccessCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, SourcedPagingSuccess<T>, $Out>
    implements
        SourcedPagingSuccessCopyWith<$R, SourcedPagingSuccess<T>, $Out, T> {
  _SourcedPagingSuccessCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SourcedPagingSuccess> $mapper =
      SourcedPagingSuccessMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      ConnectedModel<String, T>,
      ConnectedModelCopyWith<$R, ConnectedModel<String, T>,
          ConnectedModel<String, T>, String, T>> get items => ListCopyWith(
      $value.items, (v, t) => v.copyWith.$chain(t), (v) => call(items: v));
  @override
  ConnectedModelCopyWith<$R, ConnectedModel<String, int>,
          ConnectedModel<String, int>, String, int>
      get currentPageKey =>
          $value.currentPageKey.copyWith.$chain((v) => call(currentPageKey: v));
  @override
  $R call(
          {List<ConnectedModel<String, T>>? items,
          ConnectedModel<String, int>? currentPageKey,
          bool? hasReachedMax}) =>
      $apply(FieldCopyWithData({
        if (items != null) #items: items,
        if (currentPageKey != null) #currentPageKey: currentPageKey,
        if (hasReachedMax != null) #hasReachedMax: hasReachedMax
      }));
  @override
  SourcedPagingSuccess<T> $make(CopyWithData data) => SourcedPagingSuccess(
      items: data.get(#items, or: $value.items),
      currentPageKey: data.get(#currentPageKey, or: $value.currentPageKey),
      hasReachedMax: data.get(#hasReachedMax, or: $value.hasReachedMax));

  @override
  SourcedPagingSuccessCopyWith<$R2, SourcedPagingSuccess<T>, $Out2, T>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SourcedPagingSuccessCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}
