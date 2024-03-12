// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConfigFile _$ConfigFileFromJson(Map<String, dynamic> json) {
  return _ConfigFile.fromJson(json);
}

/// @nodoc
mixin _$ConfigFile {
  List<RemoteStorage>? get remotes => throw _privateConstructorUsedError;
  Map<String, String> get passwords => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigFileCopyWith<ConfigFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigFileCopyWith<$Res> {
  factory $ConfigFileCopyWith(
          ConfigFile value, $Res Function(ConfigFile) then) =
      _$ConfigFileCopyWithImpl<$Res, ConfigFile>;
  @useResult
  $Res call({List<RemoteStorage>? remotes, Map<String, String> passwords});
}

/// @nodoc
class _$ConfigFileCopyWithImpl<$Res, $Val extends ConfigFile>
    implements $ConfigFileCopyWith<$Res> {
  _$ConfigFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remotes = freezed,
    Object? passwords = null,
  }) {
    return _then(_value.copyWith(
      remotes: freezed == remotes
          ? _value.remotes
          : remotes // ignore: cast_nullable_to_non_nullable
              as List<RemoteStorage>?,
      passwords: null == passwords
          ? _value.passwords
          : passwords // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigFileImplCopyWith<$Res>
    implements $ConfigFileCopyWith<$Res> {
  factory _$$ConfigFileImplCopyWith(
          _$ConfigFileImpl value, $Res Function(_$ConfigFileImpl) then) =
      __$$ConfigFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<RemoteStorage>? remotes, Map<String, String> passwords});
}

/// @nodoc
class __$$ConfigFileImplCopyWithImpl<$Res>
    extends _$ConfigFileCopyWithImpl<$Res, _$ConfigFileImpl>
    implements _$$ConfigFileImplCopyWith<$Res> {
  __$$ConfigFileImplCopyWithImpl(
      _$ConfigFileImpl _value, $Res Function(_$ConfigFileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remotes = freezed,
    Object? passwords = null,
  }) {
    return _then(_$ConfigFileImpl(
      remotes: freezed == remotes
          ? _value._remotes
          : remotes // ignore: cast_nullable_to_non_nullable
              as List<RemoteStorage>?,
      passwords: null == passwords
          ? _value._passwords
          : passwords // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigFileImpl implements _ConfigFile {
  const _$ConfigFileImpl(
      {final List<RemoteStorage>? remotes,
      final Map<String, String> passwords = const {}})
      : _remotes = remotes,
        _passwords = passwords;

  factory _$ConfigFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigFileImplFromJson(json);

  final List<RemoteStorage>? _remotes;
  @override
  List<RemoteStorage>? get remotes {
    final value = _remotes;
    if (value == null) return null;
    if (_remotes is EqualUnmodifiableListView) return _remotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, String> _passwords;
  @override
  @JsonKey()
  Map<String, String> get passwords {
    if (_passwords is EqualUnmodifiableMapView) return _passwords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_passwords);
  }

  @override
  String toString() {
    return 'ConfigFile(remotes: $remotes, passwords: $passwords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigFileImpl &&
            const DeepCollectionEquality().equals(other._remotes, _remotes) &&
            const DeepCollectionEquality()
                .equals(other._passwords, _passwords));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_remotes),
      const DeepCollectionEquality().hash(_passwords));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigFileImplCopyWith<_$ConfigFileImpl> get copyWith =>
      __$$ConfigFileImplCopyWithImpl<_$ConfigFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigFileImplToJson(
      this,
    );
  }
}

abstract class _ConfigFile implements ConfigFile {
  const factory _ConfigFile(
      {final List<RemoteStorage>? remotes,
      final Map<String, String> passwords}) = _$ConfigFileImpl;

  factory _ConfigFile.fromJson(Map<String, dynamic> json) =
      _$ConfigFileImpl.fromJson;

  @override
  List<RemoteStorage>? get remotes;
  @override
  Map<String, String> get passwords;
  @override
  @JsonKey(ignore: true)
  _$$ConfigFileImplCopyWith<_$ConfigFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
