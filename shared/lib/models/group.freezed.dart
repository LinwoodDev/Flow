// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventGroup _$EventGroupFromJson(Map<String, dynamic> json) {
  return _EventGroup.fromJson(json);
}

/// @nodoc
mixin _$EventGroup {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<int> get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventGroupCopyWith<EventGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventGroupCopyWith<$Res> {
  factory $EventGroupCopyWith(
          EventGroup value, $Res Function(EventGroup) then) =
      _$EventGroupCopyWithImpl<$Res, EventGroup>;
  @useResult
  $Res call({int id, String name, String description, List<int> image});
}

/// @nodoc
class _$EventGroupCopyWithImpl<$Res, $Val extends EventGroup>
    implements $EventGroupCopyWith<$Res> {
  _$EventGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventGroupCopyWith<$Res>
    implements $EventGroupCopyWith<$Res> {
  factory _$$_EventGroupCopyWith(
          _$_EventGroup value, $Res Function(_$_EventGroup) then) =
      __$$_EventGroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String description, List<int> image});
}

/// @nodoc
class __$$_EventGroupCopyWithImpl<$Res>
    extends _$EventGroupCopyWithImpl<$Res, _$_EventGroup>
    implements _$$_EventGroupCopyWith<$Res> {
  __$$_EventGroupCopyWithImpl(
      _$_EventGroup _value, $Res Function(_$_EventGroup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? image = null,
  }) {
    return _then(_$_EventGroup(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value._image
          : image // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventGroup implements _EventGroup {
  const _$_EventGroup(
      {this.id = -1,
      this.name = '',
      this.description = '',
      final List<int> image = const []})
      : _image = image;

  factory _$_EventGroup.fromJson(Map<String, dynamic> json) =>
      _$$_EventGroupFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  final List<int> _image;
  @override
  @JsonKey()
  List<int> get image {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_image);
  }

  @override
  String toString() {
    return 'EventGroup(id: $id, name: $name, description: $description, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._image, _image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      const DeepCollectionEquality().hash(_image));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventGroupCopyWith<_$_EventGroup> get copyWith =>
      __$$_EventGroupCopyWithImpl<_$_EventGroup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventGroupToJson(
      this,
    );
  }
}

abstract class _EventGroup implements EventGroup {
  const factory _EventGroup(
      {final int id,
      final String name,
      final String description,
      final List<int> image}) = _$_EventGroup;

  factory _EventGroup.fromJson(Map<String, dynamic> json) =
      _$_EventGroup.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  List<int> get image;
  @override
  @JsonKey(ignore: true)
  _$$_EventGroupCopyWith<_$_EventGroup> get copyWith =>
      throw _privateConstructorUsedError;
}
