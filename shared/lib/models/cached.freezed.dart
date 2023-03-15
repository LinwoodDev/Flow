// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cached.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CachedData _$CachedDataFromJson(Map<String, dynamic> json) {
  return _CachedData.fromJson(json);
}

/// @nodoc
mixin _$CachedData {
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  List<Event> get events => throw _privateConstructorUsedError;
  List<Todo> get todos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CachedDataCopyWith<CachedData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CachedDataCopyWith<$Res> {
  factory $CachedDataCopyWith(
          CachedData value, $Res Function(CachedData) then) =
      _$CachedDataCopyWithImpl<$Res, CachedData>;
  @useResult
  $Res call({DateTime? lastUpdated, List<Event> events, List<Todo> todos});
}

/// @nodoc
class _$CachedDataCopyWithImpl<$Res, $Val extends CachedData>
    implements $CachedDataCopyWith<$Res> {
  _$CachedDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastUpdated = freezed,
    Object? events = null,
    Object? todos = null,
  }) {
    return _then(_value.copyWith(
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      todos: null == todos
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CachedDataCopyWith<$Res>
    implements $CachedDataCopyWith<$Res> {
  factory _$$_CachedDataCopyWith(
          _$_CachedData value, $Res Function(_$_CachedData) then) =
      __$$_CachedDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? lastUpdated, List<Event> events, List<Todo> todos});
}

/// @nodoc
class __$$_CachedDataCopyWithImpl<$Res>
    extends _$CachedDataCopyWithImpl<$Res, _$_CachedData>
    implements _$$_CachedDataCopyWith<$Res> {
  __$$_CachedDataCopyWithImpl(
      _$_CachedData _value, $Res Function(_$_CachedData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastUpdated = freezed,
    Object? events = null,
    Object? todos = null,
  }) {
    return _then(_$_CachedData(
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      todos: null == todos
          ? _value._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CachedData implements _CachedData {
  _$_CachedData(
      {this.lastUpdated,
      final List<Event> events = const [],
      final List<Todo> todos = const []})
      : _events = events,
        _todos = todos;

  factory _$_CachedData.fromJson(Map<String, dynamic> json) =>
      _$$_CachedDataFromJson(json);

  @override
  final DateTime? lastUpdated;
  final List<Event> _events;
  @override
  @JsonKey()
  List<Event> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  final List<Todo> _todos;
  @override
  @JsonKey()
  List<Todo> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  String toString() {
    return 'CachedData(lastUpdated: $lastUpdated, events: $events, todos: $todos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CachedData &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality().equals(other._todos, _todos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      lastUpdated,
      const DeepCollectionEquality().hash(_events),
      const DeepCollectionEquality().hash(_todos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CachedDataCopyWith<_$_CachedData> get copyWith =>
      __$$_CachedDataCopyWithImpl<_$_CachedData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CachedDataToJson(
      this,
    );
  }
}

abstract class _CachedData implements CachedData {
  factory _CachedData(
      {final DateTime? lastUpdated,
      final List<Event> events,
      final List<Todo> todos}) = _$_CachedData;

  factory _CachedData.fromJson(Map<String, dynamic> json) =
      _$_CachedData.fromJson;

  @override
  DateTime? get lastUpdated;
  @override
  List<Event> get events;
  @override
  List<Todo> get todos;
  @override
  @JsonKey(ignore: true)
  _$$_CachedDataCopyWith<_$_CachedData> get copyWith =>
      throw _privateConstructorUsedError;
}