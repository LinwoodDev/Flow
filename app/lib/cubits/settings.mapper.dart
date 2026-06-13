// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
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

class CalendarViewMapper extends EnumMapper<CalendarView> {
  CalendarViewMapper._();

  static CalendarViewMapper? _instance;
  static CalendarViewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CalendarViewMapper._());
    }
    return _instance!;
  }

  static CalendarView fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CalendarView decode(dynamic value) {
    switch (value) {
      case r'list':
        return CalendarView.list;
      case r'day':
        return CalendarView.day;
      case r'week':
        return CalendarView.week;
      case r'month':
        return CalendarView.month;
      case r'pending':
        return CalendarView.pending;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CalendarView self) {
    switch (self) {
      case CalendarView.list:
        return r'list';
      case CalendarView.day:
        return r'day';
      case CalendarView.week:
        return r'week';
      case CalendarView.month:
        return r'month';
      case CalendarView.pending:
        return r'pending';
    }
  }
}

extension CalendarViewMapperExtension on CalendarView {
  String toValue() {
    CalendarViewMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CalendarView>(this) as String;
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
      CalendarViewMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FlowSettings';

  static String _$locale(FlowSettings v) => v.locale;
  static const Field<FlowSettings, String> _f$locale = Field(
    'locale',
    _$locale,
    opt: true,
    def: '',
  );
  static ThemeMode _$themeMode(FlowSettings v) => v.themeMode;
  static const Field<FlowSettings, ThemeMode> _f$themeMode = Field(
    'themeMode',
    _$themeMode,
    opt: true,
    def: ThemeMode.system,
  );
  static bool _$nativeTitleBar(FlowSettings v) => v.nativeTitleBar;
  static const Field<FlowSettings, bool> _f$nativeTitleBar = Field(
    'nativeTitleBar',
    _$nativeTitleBar,
    opt: true,
    def: false,
  );
  static String _$design(FlowSettings v) => v.design;
  static const Field<FlowSettings, String> _f$design = Field(
    'design',
    _$design,
    opt: true,
    def: '',
  );
  static SyncMode _$syncMode(FlowSettings v) => v.syncMode;
  static const Field<FlowSettings, SyncMode> _f$syncMode = Field(
    'syncMode',
    _$syncMode,
    opt: true,
    def: SyncMode.noMobile,
  );
  static List<RemoteStorage> _$remotes(FlowSettings v) => v.remotes;
  static const Field<FlowSettings, List<RemoteStorage>> _f$remotes = Field(
    'remotes',
    _$remotes,
    opt: true,
    def: const [],
  );
  static int _$startOfWeek(FlowSettings v) => v.startOfWeek;
  static const Field<FlowSettings, int> _f$startOfWeek = Field(
    'startOfWeek',
    _$startOfWeek,
    opt: true,
    def: 0,
  );
  static ThemeDensity _$density(FlowSettings v) => v.density;
  static const Field<FlowSettings, ThemeDensity> _f$density = Field(
    'density',
    _$density,
    opt: true,
    def: ThemeDensity.system,
  );
  static bool _$highContrast(FlowSettings v) => v.highContrast;
  static const Field<FlowSettings, bool> _f$highContrast = Field(
    'highContrast',
    _$highContrast,
    opt: true,
    def: false,
  );
  static CalendarView _$calendarView(FlowSettings v) => v.calendarView;
  static const Field<FlowSettings, CalendarView> _f$calendarView = Field(
    'calendarView',
    _$calendarView,
    opt: true,
    def: CalendarView.list,
  );

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
    #calendarView: _f$calendarView,
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
      calendarView: data.dec(_f$calendarView),
    );
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
    return FlowSettingsMapper.ensureInitialized().encodeJson<FlowSettings>(
      this as FlowSettings,
    );
  }

  Map<String, dynamic> toMap() {
    return FlowSettingsMapper.ensureInitialized().encodeMap<FlowSettings>(
      this as FlowSettings,
    );
  }

  FlowSettingsCopyWith<FlowSettings, FlowSettings, FlowSettings> get copyWith =>
      _FlowSettingsCopyWithImpl<FlowSettings, FlowSettings>(
        this as FlowSettings,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return FlowSettingsMapper.ensureInitialized().stringifyValue(
      this as FlowSettings,
    );
  }

  @override
  bool operator ==(Object other) {
    return FlowSettingsMapper.ensureInitialized().equalsValue(
      this as FlowSettings,
      other,
    );
  }

  @override
  int get hashCode {
    return FlowSettingsMapper.ensureInitialized().hashValue(
      this as FlowSettings,
    );
  }
}

extension FlowSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FlowSettings, $Out> {
  FlowSettingsCopyWith<$R, FlowSettings, $Out> get $asFlowSettings =>
      $base.as((v, t, t2) => _FlowSettingsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FlowSettingsCopyWith<$R, $In extends FlowSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    RemoteStorage,
    RemoteStorageCopyWith<$R, RemoteStorage, RemoteStorage>
  >
  get remotes;
  $R call({
    String? locale,
    ThemeMode? themeMode,
    bool? nativeTitleBar,
    String? design,
    SyncMode? syncMode,
    List<RemoteStorage>? remotes,
    int? startOfWeek,
    ThemeDensity? density,
    bool? highContrast,
    CalendarView? calendarView,
  });
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
  ListCopyWith<
    $R,
    RemoteStorage,
    RemoteStorageCopyWith<$R, RemoteStorage, RemoteStorage>
  >
  get remotes => ListCopyWith(
    $value.remotes,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(remotes: v),
  );
  @override
  $R call({
    String? locale,
    ThemeMode? themeMode,
    bool? nativeTitleBar,
    String? design,
    SyncMode? syncMode,
    List<RemoteStorage>? remotes,
    int? startOfWeek,
    ThemeDensity? density,
    bool? highContrast,
    CalendarView? calendarView,
  }) => $apply(
    FieldCopyWithData({
      if (locale != null) #locale: locale,
      if (themeMode != null) #themeMode: themeMode,
      if (nativeTitleBar != null) #nativeTitleBar: nativeTitleBar,
      if (design != null) #design: design,
      if (syncMode != null) #syncMode: syncMode,
      if (remotes != null) #remotes: remotes,
      if (startOfWeek != null) #startOfWeek: startOfWeek,
      if (density != null) #density: density,
      if (highContrast != null) #highContrast: highContrast,
      if (calendarView != null) #calendarView: calendarView,
    }),
  );
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
    calendarView: data.get(#calendarView, or: $value.calendarView),
  );

  @override
  FlowSettingsCopyWith<$R2, FlowSettings, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FlowSettingsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

