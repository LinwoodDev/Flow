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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Note _$NoteFromJson(Map<String, dynamic> json) {
  return _Note.fromJson(json);
}

/// @nodoc
mixin _$Note {
  @MultihashConverter()
  Multihash? get id => throw _privateConstructorUsedError;
  @MultihashConverter()
  Multihash? get parentId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  NoteStatus? get status => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteCopyWith<Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCopyWith<$Res> {
  factory $NoteCopyWith(Note value, $Res Function(Note) then) =
      _$NoteCopyWithImpl<$Res, Note>;
  @useResult
  $Res call(
      {@MultihashConverter() Multihash? id,
      @MultihashConverter() Multihash? parentId,
      String name,
      String description,
      NoteStatus? status,
      int priority});
}

/// @nodoc
class _$NoteCopyWithImpl<$Res, $Val extends Note>
    implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? parentId = freezed,
    Object? name = null,
    Object? description = null,
    Object? status = freezed,
    Object? priority = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NoteStatus?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$$_NoteCopyWith(_$_Note value, $Res Function(_$_Note) then) =
      __$$_NoteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@MultihashConverter() Multihash? id,
      @MultihashConverter() Multihash? parentId,
      String name,
      String description,
      NoteStatus? status,
      int priority});
}

/// @nodoc
class __$$_NoteCopyWithImpl<$Res> extends _$NoteCopyWithImpl<$Res, _$_Note>
    implements _$$_NoteCopyWith<$Res> {
  __$$_NoteCopyWithImpl(_$_Note _value, $Res Function(_$_Note) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? parentId = freezed,
    Object? name = null,
    Object? description = null,
    Object? status = freezed,
    Object? priority = null,
  }) {
    return _then(_$_Note(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NoteStatus?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Note extends _Note {
  const _$_Note(
      {@MultihashConverter() this.id,
      @MultihashConverter() this.parentId,
      this.name = '',
      this.description = '',
      this.status,
      this.priority = 0})
      : super._();

  factory _$_Note.fromJson(Map<String, dynamic> json) => _$$_NoteFromJson(json);

  @override
  @MultihashConverter()
  final Multihash? id;
  @override
  @MultihashConverter()
  final Multihash? parentId;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  final NoteStatus? status;
  @override
  @JsonKey()
  final int priority;

  @override
  String toString() {
    return 'Note(id: $id, parentId: $parentId, name: $name, description: $description, status: $status, priority: $priority)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Note &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, parentId, name, description, status, priority);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteCopyWith<_$_Note> get copyWith =>
      __$$_NoteCopyWithImpl<_$_Note>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoteToJson(
      this,
    );
  }
}

abstract class _Note extends Note implements DescriptiveModel {
  const factory _Note(
      {@MultihashConverter() final Multihash? id,
      @MultihashConverter() final Multihash? parentId,
      final String name,
      final String description,
      final NoteStatus? status,
      final int priority}) = _$_Note;
  const _Note._() : super._();

  factory _Note.fromJson(Map<String, dynamic> json) = _$_Note.fromJson;

  @override
  @MultihashConverter()
  Multihash? get id;
  @override
  @MultihashConverter()
  Multihash? get parentId;
  @override
  String get name;
  @override
  String get description;
  @override
  NoteStatus? get status;
  @override
  int get priority;
  @override
  @JsonKey(ignore: true)
  _$$_NoteCopyWith<_$_Note> get copyWith => throw _privateConstructorUsedError;
}
