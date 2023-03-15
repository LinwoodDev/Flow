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
  String get locale => throw _privateConstructorUsedError;
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  bool get nativeTitleBar => throw _privateConstructorUsedError;
  String get design => throw _privateConstructorUsedError;
  SyncMode get syncMode => throw _privateConstructorUsedError;
  List<RemoteStorage> get remotes => throw _privateConstructorUsedError;

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
  $Res call(
      {String locale,
      ThemeMode themeMode,
      bool nativeTitleBar,
      String design,
      SyncMode syncMode,
      List<RemoteStorage> remotes});
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
    Object? locale = null,
    Object? themeMode = null,
    Object? nativeTitleBar = null,
    Object? design = null,
    Object? syncMode = null,
    Object? remotes = null,
  }) {
    return _then(_value.copyWith(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
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
      syncMode: null == syncMode
          ? _value.syncMode
          : syncMode // ignore: cast_nullable_to_non_nullable
              as SyncMode,
      remotes: null == remotes
          ? _value.remotes
          : remotes // ignore: cast_nullable_to_non_nullable
              as List<RemoteStorage>,
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
  $Res call(
      {String locale,
      ThemeMode themeMode,
      bool nativeTitleBar,
      String design,
      SyncMode syncMode,
      List<RemoteStorage> remotes});
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
    Object? locale = null,
    Object? themeMode = null,
    Object? nativeTitleBar = null,
    Object? design = null,
    Object? syncMode = null,
    Object? remotes = null,
  }) {
    return _then(_$_FlowSettings(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String,
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
      syncMode: null == syncMode
          ? _value.syncMode
          : syncMode // ignore: cast_nullable_to_non_nullable
              as SyncMode,
      remotes: null == remotes
          ? _value._remotes
          : remotes // ignore: cast_nullable_to_non_nullable
              as List<RemoteStorage>,
    ));
  }
}

/// @nodoc

class _$_FlowSettings extends _FlowSettings {
  const _$_FlowSettings(
      {this.locale = '',
      this.themeMode = ThemeMode.system,
      this.nativeTitleBar = false,
      this.design = '',
      this.syncMode = SyncMode.noMobile,
      final List<RemoteStorage> remotes = const []})
      : _remotes = remotes,
        super._();

  @override
  @JsonKey()
  final String locale;
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
  @JsonKey()
  final SyncMode syncMode;
  final List<RemoteStorage> _remotes;
  @override
  @JsonKey()
  List<RemoteStorage> get remotes {
    if (_remotes is EqualUnmodifiableListView) return _remotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remotes);
  }

  @override
  String toString() {
    return 'FlowSettings(locale: $locale, themeMode: $themeMode, nativeTitleBar: $nativeTitleBar, design: $design, syncMode: $syncMode, remotes: $remotes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FlowSettings &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.nativeTitleBar, nativeTitleBar) ||
                other.nativeTitleBar == nativeTitleBar) &&
            (identical(other.design, design) || other.design == design) &&
            (identical(other.syncMode, syncMode) ||
                other.syncMode == syncMode) &&
            const DeepCollectionEquality().equals(other._remotes, _remotes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      locale,
      themeMode,
      nativeTitleBar,
      design,
      syncMode,
      const DeepCollectionEquality().hash(_remotes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FlowSettingsCopyWith<_$_FlowSettings> get copyWith =>
      __$$_FlowSettingsCopyWithImpl<_$_FlowSettings>(this, _$identity);
}

abstract class _FlowSettings extends FlowSettings {
  const factory _FlowSettings(
      {final String locale,
      final ThemeMode themeMode,
      final bool nativeTitleBar,
      final String design,
      final SyncMode syncMode,
      final List<RemoteStorage> remotes}) = _$_FlowSettings;
  const _FlowSettings._() : super._();

  @override
  String get locale;
  @override
  ThemeMode get themeMode;
  @override
  bool get nativeTitleBar;
  @override
  String get design;
  @override
  SyncMode get syncMode;
  @override
  List<RemoteStorage> get remotes;
  @override
  @JsonKey(ignore: true)
  _$$_FlowSettingsCopyWith<_$_FlowSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
