// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FlowSettings {
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  bool get nativeTitleBar => throw _privateConstructorUsedError;
  String get design => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FlowSettingsCopyWith<FlowSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlowSettingsCopyWith<$Res> {
  factory $FlowSettingsCopyWith(
          FlowSettings value, $Res Function(FlowSettings) then) =
      _$FlowSettingsCopyWithImpl<$Res, FlowSettings>;
  @useResult
  $Res call({ThemeMode themeMode, bool nativeTitleBar, String design});
}

/// @nodoc
class _$FlowSettingsCopyWithImpl<$Res, $Val extends FlowSettings>
    implements $FlowSettingsCopyWith<$Res> {
  _$FlowSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? nativeTitleBar = null,
    Object? design = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      nativeTitleBar: null == nativeTitleBar
          ? _value.nativeTitleBar
          : nativeTitleBar // ignore: cast_nullable_to_non_nullable
              as bool,
      design: null == design
          ? _value.design
          : design // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FlowSettingsCopyWith<$Res>
    implements $FlowSettingsCopyWith<$Res> {
  factory _$$_FlowSettingsCopyWith(
          _$_FlowSettings value, $Res Function(_$_FlowSettings) then) =
      __$$_FlowSettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ThemeMode themeMode, bool nativeTitleBar, String design});
}

/// @nodoc
class __$$_FlowSettingsCopyWithImpl<$Res>
    extends _$FlowSettingsCopyWithImpl<$Res, _$_FlowSettings>
    implements _$$_FlowSettingsCopyWith<$Res> {
  __$$_FlowSettingsCopyWithImpl(
      _$_FlowSettings _value, $Res Function(_$_FlowSettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? nativeTitleBar = null,
    Object? design = null,
  }) {
    return _then(_$_FlowSettings(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      nativeTitleBar: null == nativeTitleBar
          ? _value.nativeTitleBar
          : nativeTitleBar // ignore: cast_nullable_to_non_nullable
              as bool,
      design: null == design
          ? _value.design
          : design // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_FlowSettings extends _FlowSettings {
  const _$_FlowSettings(
      {this.themeMode = ThemeMode.system,
      this.nativeTitleBar = false,
      this.design = ''})
      : super._();

  @override
  @JsonKey()
  final ThemeMode themeMode;
  @override
  @JsonKey()
  final bool nativeTitleBar;
  @override
  @JsonKey()
  final String design;

  @override
  String toString() {
    return 'FlowSettings(themeMode: $themeMode, nativeTitleBar: $nativeTitleBar, design: $design)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FlowSettings &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.nativeTitleBar, nativeTitleBar) ||
                other.nativeTitleBar == nativeTitleBar) &&
            (identical(other.design, design) || other.design == design));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, themeMode, nativeTitleBar, design);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FlowSettingsCopyWith<_$_FlowSettings> get copyWith =>
      __$$_FlowSettingsCopyWithImpl<_$_FlowSettings>(this, _$identity);
}

abstract class _FlowSettings extends FlowSettings {
  const factory _FlowSettings(
      {final ThemeMode themeMode,
      final bool nativeTitleBar,
      final String design}) = _$_FlowSettings;
  const _FlowSettings._() : super._();

  @override
  ThemeMode get themeMode;
  @override
  bool get nativeTitleBar;
  @override
  String get design;
  @override
  @JsonKey(ignore: true)
  _$$_FlowSettingsCopyWith<_$_FlowSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
