// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  @Uint8ListConverter()
  Uint8List? get id => throw _privateConstructorUsedError;
  @Uint8ListConverter()
  Uint8List? get parentId => throw _privateConstructorUsedError;
  @Uint8ListConverter()
  Uint8List? get groupId => throw _privateConstructorUsedError;
  @Uint8ListConverter()
  Uint8List? get placeId => throw _privateConstructorUsedError;
  bool get blocked => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String? get extra => throw _privateConstructorUsedError;

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {@Uint8ListConverter() Uint8List? id,
      @Uint8ListConverter() Uint8List? parentId,
      @Uint8ListConverter() Uint8List? groupId,
      @Uint8ListConverter() Uint8List? placeId,
      bool blocked,
      String name,
      String description,
      String location,
      String? extra});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? parentId = freezed,
    Object? groupId = freezed,
    Object? placeId = freezed,
    Object? blocked = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? extra = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      blocked: null == blocked
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      extra: freezed == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
          _$EventImpl value, $Res Function(_$EventImpl) then) =
      __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Uint8ListConverter() Uint8List? id,
      @Uint8ListConverter() Uint8List? parentId,
      @Uint8ListConverter() Uint8List? groupId,
      @Uint8ListConverter() Uint8List? placeId,
      bool blocked,
      String name,
      String description,
      String location,
      String? extra});
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
      _$EventImpl _value, $Res Function(_$EventImpl) _then)
      : super(_value, _then);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? parentId = freezed,
    Object? groupId = freezed,
    Object? placeId = freezed,
    Object? blocked = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? extra = freezed,
  }) {
    return _then(_$EventImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      placeId: freezed == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      blocked: null == blocked
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      extra: freezed == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl extends _Event {
  const _$EventImpl(
      {@Uint8ListConverter() this.id,
      @Uint8ListConverter() this.parentId,
      @Uint8ListConverter() this.groupId,
      @Uint8ListConverter() this.placeId,
      this.blocked = true,
      this.name = '',
      this.description = '',
      this.location = '',
      this.extra})
      : super._();

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  @Uint8ListConverter()
  final Uint8List? id;
  @override
  @Uint8ListConverter()
  final Uint8List? parentId;
  @override
  @Uint8ListConverter()
  final Uint8List? groupId;
  @override
  @Uint8ListConverter()
  final Uint8List? placeId;
  @override
  @JsonKey()
  final bool blocked;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String location;
  @override
  final String? extra;

  @override
  String toString() {
    return 'Event(id: $id, parentId: $parentId, groupId: $groupId, placeId: $placeId, blocked: $blocked, name: $name, description: $description, location: $location, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.parentId, parentId) &&
            const DeepCollectionEquality().equals(other.groupId, groupId) &&
            const DeepCollectionEquality().equals(other.placeId, placeId) &&
            (identical(other.blocked, blocked) || other.blocked == blocked) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.extra, extra) || other.extra == extra));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(parentId),
      const DeepCollectionEquality().hash(groupId),
      const DeepCollectionEquality().hash(placeId),
      blocked,
      name,
      description,
      location,
      extra);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(
      this,
    );
  }
}

abstract class _Event extends Event implements DescriptiveModel {
  const factory _Event(
      {@Uint8ListConverter() final Uint8List? id,
      @Uint8ListConverter() final Uint8List? parentId,
      @Uint8ListConverter() final Uint8List? groupId,
      @Uint8ListConverter() final Uint8List? placeId,
      final bool blocked,
      final String name,
      final String description,
      final String location,
      final String? extra}) = _$EventImpl;
  const _Event._() : super._();

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  @Uint8ListConverter()
  Uint8List? get id;
  @override
  @Uint8ListConverter()
  Uint8List? get parentId;
  @override
  @Uint8ListConverter()
  Uint8List? get groupId;
  @override
  @Uint8ListConverter()
  Uint8List? get placeId;
  @override
  bool get blocked;
  @override
  String get name;
  @override
  String get description;
  @override
  String get location;
  @override
  String? get extra;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
