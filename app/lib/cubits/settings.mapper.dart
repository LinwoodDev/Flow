// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings.dart';

class ThemeDensityMapper extends EnumMapper<ThemeDensity> {
  ThemeDensityMapper._();

  static ThemeDensityMapper? _instance;
  static ThemeDensityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ThemeDensityMapper._());
    }
    return _instance!;
  }

  static ThemeDensity fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ThemeDensity decode(dynamic value) {
    switch (value) {
      case r'system':
        return ThemeDensity.system;
      case r'maximize':
        return ThemeDensity.maximize;
      case r'desktop':
        return ThemeDensity.desktop;
      case r'compact':
        return ThemeDensity.compact;
      case r'comfortable':
        return ThemeDensity.comfortable;
      case r'standard':
        return ThemeDensity.standard;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ThemeDensity self) {
    switch (self) {
      case ThemeDensity.system:
        return r'system';
      case ThemeDensity.maximize:
        return r'maximize';
      case ThemeDensity.desktop:
        return r'desktop';
      case ThemeDensity.compact:
        return r'compact';
      case ThemeDensity.comfortable:
        return r'comfortable';
      case ThemeDensity.standard:
        return r'standard';
    }
  }
}

extension ThemeDensityMapperExtension on ThemeDensity {
  String toValue() {
    ThemeDensityMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ThemeDensity>(this) as String;
  }
}

class SyncModeMapper extends EnumMapper<SyncMode> {
  SyncModeMapper._();

  static SyncModeMapper? _instance;
  static SyncModeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SyncModeMapper._());
    }
    return _instance!;
  }

  static SyncMode fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SyncMode decode(dynamic value) {
    switch (value) {
      case r'always':
        return SyncMode.always;
      case r'noMobile':
        return SyncMode.noMobile;
      case r'manual':
        return SyncMode.manual;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SyncMode self) {
    switch (self) {
      case SyncMode.always:
        return r'always';
      case SyncMode.noMobile:
        return r'noMobile';
      case SyncMode.manual:
        return r'manual';
    }
  }
}

extension SyncModeMapperExtension on SyncMode {
  String toValue() {
    SyncModeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SyncMode>(this) as String;
  }
}

class AlarmMapper extends ClassMapperBase<Alarm> {
  AlarmMapper._();

  static AlarmMapper? _instance;
  static AlarmMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AlarmMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Alarm';

  static DateTime _$date(Alarm v) => v.date;
  static const Field<Alarm, DateTime> _f$date = Field('date', _$date);
  static String _$title(Alarm v) => v.title;
  static const Field<Alarm, String> _f$title =
      Field('title', _$title, opt: true, def: '');
  static String _$description(Alarm v) => v.description;
  static const Field<Alarm, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static bool _$isActive(Alarm v) => v.isActive;
  static const Field<Alarm, bool> _f$isActive =
      Field('isActive', _$isActive, opt: true, def: true);

  @override
  final MappableFields<Alarm> fields = const {
    #date: _f$date,
    #title: _f$title,
    #description: _f$description,
    #isActive: _f$isActive,
  };

  static Alarm _instantiate(DecodingData data) {
    return Alarm(
        date: data.dec(_f$date),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        isActive: data.dec(_f$isActive));
  }

  @override
  final Function instantiate = _instantiate;

  static Alarm fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Alarm>(map);
  }

  static Alarm fromJson(String json) {
    return ensureInitialized().decodeJson<Alarm>(json);
  }
}

mixin AlarmMappable {
  String toJson() {
    return AlarmMapper.ensureInitialized().encodeJson<Alarm>(this as Alarm);
  }

  Map<String, dynamic> toMap() {
    return AlarmMapper.ensureInitialized().encodeMap<Alarm>(this as Alarm);
  }

  AlarmCopyWith<Alarm, Alarm, Alarm> get copyWith =>
      _AlarmCopyWithImpl<Alarm, Alarm>(this as Alarm, $identity, $identity);
  @override
  String toString() {
    return AlarmMapper.ensureInitialized().stringifyValue(this as Alarm);
  }

  @override
  bool operator ==(Object other) {
    return AlarmMapper.ensureInitialized().equalsValue(this as Alarm, other);
  }

  @override
  int get hashCode {
    return AlarmMapper.ensureInitialized().hashValue(this as Alarm);
  }
}

extension AlarmValueCopy<$R, $Out> on ObjectCopyWith<$R, Alarm, $Out> {
  AlarmCopyWith<$R, Alarm, $Out> get $asAlarm =>
      $base.as((v, t, t2) => _AlarmCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AlarmCopyWith<$R, $In extends Alarm, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({DateTime? date, String? title, String? description, bool? isActive});
  AlarmCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AlarmCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Alarm, $Out>
    implements AlarmCopyWith<$R, Alarm, $Out> {
  _AlarmCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Alarm> $mapper = AlarmMapper.ensureInitialized();
  @override
  $R call(
          {DateTime? date,
          String? title,
          String? description,
          bool? isActive}) =>
      $apply(FieldCopyWithData({
        if (date != null) #date: date,
        if (title != null) #title: title,
        if (description != null) #description: description,
        if (isActive != null) #isActive: isActive
      }));
  @override
  Alarm $make(CopyWithData data) => Alarm(
      date: data.get(#date, or: $value.date),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      isActive: data.get(#isActive, or: $value.isActive));

  @override
  AlarmCopyWith<$R2, Alarm, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AlarmCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class FlowSettingsMapper extends ClassMapperBase<FlowSettings> {
  FlowSettingsMapper._();

  static FlowSettingsMapper? _instance;
  static FlowSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlowSettingsMapper._());
      MapperContainer.globals.useAll([ThemeModeMapper()]);
      SyncModeMapper.ensureInitialized();
      RemoteStorageMapper.ensureInitialized();
      ThemeDensityMapper.ensureInitialized();
      AlarmMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FlowSettings';

  static String _$locale(FlowSettings v) => v.locale;
  static const Field<FlowSettings, String> _f$locale =
      Field('locale', _$locale, opt: true, def: '');
  static ThemeMode _$themeMode(FlowSettings v) => v.themeMode;
  static const Field<FlowSettings, ThemeMode> _f$themeMode =
      Field('themeMode', _$themeMode, opt: true, def: ThemeMode.system);
  static bool _$nativeTitleBar(FlowSettings v) => v.nativeTitleBar;
  static const Field<FlowSettings, bool> _f$nativeTitleBar =
      Field('nativeTitleBar', _$nativeTitleBar, opt: true, def: false);
  static String _$design(FlowSettings v) => v.design;
  static const Field<FlowSettings, String> _f$design =
      Field('design', _$design, opt: true, def: '');
  static SyncMode _$syncMode(FlowSettings v) => v.syncMode;
  static const Field<FlowSettings, SyncMode> _f$syncMode =
      Field('syncMode', _$syncMode, opt: true, def: SyncMode.noMobile);
  static List<RemoteStorage> _$remotes(FlowSettings v) => v.remotes;
  static const Field<FlowSettings, List<RemoteStorage>> _f$remotes =
      Field('remotes', _$remotes, opt: true, def: const []);
  static int _$startOfWeek(FlowSettings v) => v.startOfWeek;
  static const Field<FlowSettings, int> _f$startOfWeek =
      Field('startOfWeek', _$startOfWeek, opt: true, def: 0);
  static ThemeDensity _$density(FlowSettings v) => v.density;
  static const Field<FlowSettings, ThemeDensity> _f$density =
      Field('density', _$density, opt: true, def: ThemeDensity.system);
  static bool _$highContrast(FlowSettings v) => v.highContrast;
  static const Field<FlowSettings, bool> _f$highContrast =
      Field('highContrast', _$highContrast, opt: true, def: false);
  static List<Alarm> _$alarms(FlowSettings v) => v.alarms;
  static const Field<FlowSettings, List<Alarm>> _f$alarms =
      Field('alarms', _$alarms, opt: true, def: const []);

  @override
  final MappableFields<FlowSettings> fields = const {
    #locale: _f$locale,
    #themeMode: _f$themeMode,
    #nativeTitleBar: _f$nativeTitleBar,
    #design: _f$design,
    #syncMode: _f$syncMode,
    #remotes: _f$remotes,
    #startOfWeek: _f$startOfWeek,
    #density: _f$density,
    #highContrast: _f$highContrast,
    #alarms: _f$alarms,
  };

  static FlowSettings _instantiate(DecodingData data) {
    return FlowSettings(
        locale: data.dec(_f$locale),
        themeMode: data.dec(_f$themeMode),
        nativeTitleBar: data.dec(_f$nativeTitleBar),
        design: data.dec(_f$design),
        syncMode: data.dec(_f$syncMode),
        remotes: data.dec(_f$remotes),
        startOfWeek: data.dec(_f$startOfWeek),
        density: data.dec(_f$density),
        highContrast: data.dec(_f$highContrast),
        alarms: data.dec(_f$alarms));
  }

  @override
  final Function instantiate = _instantiate;

  static FlowSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlowSettings>(map);
  }

  static FlowSettings fromJson(String json) {
    return ensureInitialized().decodeJson<FlowSettings>(json);
  }
}

mixin FlowSettingsMappable {
  String toJson() {
    return FlowSettingsMapper.ensureInitialized()
        .encodeJson<FlowSettings>(this as FlowSettings);
  }

  Map<String, dynamic> toMap() {
    return FlowSettingsMapper.ensureInitialized()
        .encodeMap<FlowSettings>(this as FlowSettings);
  }

  FlowSettingsCopyWith<FlowSettings, FlowSettings, FlowSettings> get copyWith =>
      _FlowSettingsCopyWithImpl<FlowSettings, FlowSettings>(
          this as FlowSettings, $identity, $identity);
  @override
  String toString() {
    return FlowSettingsMapper.ensureInitialized()
        .stringifyValue(this as FlowSettings);
  }

  @override
  bool operator ==(Object other) {
    return FlowSettingsMapper.ensureInitialized()
        .equalsValue(this as FlowSettings, other);
  }

  @override
  int get hashCode {
    return FlowSettingsMapper.ensureInitialized()
        .hashValue(this as FlowSettings);
  }
}

extension FlowSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlowSettings, $Out> {
  FlowSettingsCopyWith<$R, FlowSettings, $Out> get $asFlowSettings =>
      $base.as((v, t, t2) => _FlowSettingsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FlowSettingsCopyWith<$R, $In extends FlowSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, RemoteStorage,
      ObjectCopyWith<$R, RemoteStorage, RemoteStorage>> get remotes;
  ListCopyWith<$R, Alarm, AlarmCopyWith<$R, Alarm, Alarm>> get alarms;
  $R call(
      {String? locale,
      ThemeMode? themeMode,
      bool? nativeTitleBar,
      String? design,
      SyncMode? syncMode,
      List<RemoteStorage>? remotes,
      int? startOfWeek,
      ThemeDensity? density,
      bool? highContrast,
      List<Alarm>? alarms});
  FlowSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FlowSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlowSettings, $Out>
    implements FlowSettingsCopyWith<$R, FlowSettings, $Out> {
  _FlowSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlowSettings> $mapper =
      FlowSettingsMapper.ensureInitialized();
  @override
  ListCopyWith<$R, RemoteStorage,
          ObjectCopyWith<$R, RemoteStorage, RemoteStorage>>
      get remotes => ListCopyWith($value.remotes,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(remotes: v));
  @override
  ListCopyWith<$R, Alarm, AlarmCopyWith<$R, Alarm, Alarm>> get alarms =>
      ListCopyWith($value.alarms, (v, t) => v.copyWith.$chain(t),
          (v) => call(alarms: v));
  @override
  $R call(
          {String? locale,
          ThemeMode? themeMode,
          bool? nativeTitleBar,
          String? design,
          SyncMode? syncMode,
          List<RemoteStorage>? remotes,
          int? startOfWeek,
          ThemeDensity? density,
          bool? highContrast,
          List<Alarm>? alarms}) =>
      $apply(FieldCopyWithData({
        if (locale != null) #locale: locale,
        if (themeMode != null) #themeMode: themeMode,
        if (nativeTitleBar != null) #nativeTitleBar: nativeTitleBar,
        if (design != null) #design: design,
        if (syncMode != null) #syncMode: syncMode,
        if (remotes != null) #remotes: remotes,
        if (startOfWeek != null) #startOfWeek: startOfWeek,
        if (density != null) #density: density,
        if (highContrast != null) #highContrast: highContrast,
        if (alarms != null) #alarms: alarms
      }));
  @override
  FlowSettings $make(CopyWithData data) => FlowSettings(
      locale: data.get(#locale, or: $value.locale),
      themeMode: data.get(#themeMode, or: $value.themeMode),
      nativeTitleBar: data.get(#nativeTitleBar, or: $value.nativeTitleBar),
      design: data.get(#design, or: $value.design),
      syncMode: data.get(#syncMode, or: $value.syncMode),
      remotes: data.get(#remotes, or: $value.remotes),
      startOfWeek: data.get(#startOfWeek, or: $value.startOfWeek),
      density: data.get(#density, or: $value.density),
      highContrast: data.get(#highContrast, or: $value.highContrast),
      alarms: data.get(#alarms, or: $value.alarms));

  @override
  FlowSettingsCopyWith<$R2, FlowSettings, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FlowSettingsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
