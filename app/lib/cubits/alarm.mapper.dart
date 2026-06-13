// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'alarm.dart';

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

  static String _$id(Alarm v) => v.id;
  static const Field<Alarm, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
    def: '',
  );
  static int _$notificationId(Alarm v) => v.notificationId;
  static const Field<Alarm, int> _f$notificationId = Field(
    'notificationId',
    _$notificationId,
    opt: true,
    def: 0,
  );
  static DateTime _$date(Alarm v) => v.date;
  static const Field<Alarm, DateTime> _f$date = Field('date', _$date);
  static String _$title(Alarm v) => v.title;
  static const Field<Alarm, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
    def: '',
  );
  static String _$description(Alarm v) => v.description;
  static const Field<Alarm, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static bool _$isActive(Alarm v) => v.isActive;
  static const Field<Alarm, bool> _f$isActive = Field(
    'isActive',
    _$isActive,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<Alarm> fields = const {
    #id: _f$id,
    #notificationId: _f$notificationId,
    #date: _f$date,
    #title: _f$title,
    #description: _f$description,
    #isActive: _f$isActive,
  };

  static Alarm _instantiate(DecodingData data) {
    return Alarm(
      id: data.dec(_f$id),
      notificationId: data.dec(_f$notificationId),
      date: data.dec(_f$date),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      isActive: data.dec(_f$isActive),
    );
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
  $R call({
    String? id,
    int? notificationId,
    DateTime? date,
    String? title,
    String? description,
    bool? isActive,
  });
  AlarmCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AlarmCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Alarm, $Out>
    implements AlarmCopyWith<$R, Alarm, $Out> {
  _AlarmCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Alarm> $mapper = AlarmMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    int? notificationId,
    DateTime? date,
    String? title,
    String? description,
    bool? isActive,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (notificationId != null) #notificationId: notificationId,
      if (date != null) #date: date,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (isActive != null) #isActive: isActive,
    }),
  );
  @override
  Alarm $make(CopyWithData data) => Alarm(
    id: data.get(#id, or: $value.id),
    notificationId: data.get(#notificationId, or: $value.notificationId),
    date: data.get(#date, or: $value.date),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    isActive: data.get(#isActive, or: $value.isActive),
  );

  @override
  AlarmCopyWith<$R2, Alarm, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AlarmCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AlarmStateMapper extends ClassMapperBase<AlarmState> {
  AlarmStateMapper._();

  static AlarmStateMapper? _instance;
  static AlarmStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AlarmStateMapper._());
      AlarmMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AlarmState';

  static List<Alarm> _$alarms(AlarmState v) => v.alarms;
  static const Field<AlarmState, List<Alarm>> _f$alarms = Field(
    'alarms',
    _$alarms,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<AlarmState> fields = const {#alarms: _f$alarms};

  static AlarmState _instantiate(DecodingData data) {
    return AlarmState(alarms: data.dec(_f$alarms));
  }

  @override
  final Function instantiate = _instantiate;

  static AlarmState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AlarmState>(map);
  }

  static AlarmState fromJson(String json) {
    return ensureInitialized().decodeJson<AlarmState>(json);
  }
}

mixin AlarmStateMappable {
  String toJson() {
    return AlarmStateMapper.ensureInitialized().encodeJson<AlarmState>(
      this as AlarmState,
    );
  }

  Map<String, dynamic> toMap() {
    return AlarmStateMapper.ensureInitialized().encodeMap<AlarmState>(
      this as AlarmState,
    );
  }

  AlarmStateCopyWith<AlarmState, AlarmState, AlarmState> get copyWith =>
      _AlarmStateCopyWithImpl<AlarmState, AlarmState>(
        this as AlarmState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AlarmStateMapper.ensureInitialized().stringifyValue(
      this as AlarmState,
    );
  }

  @override
  bool operator ==(Object other) {
    return AlarmStateMapper.ensureInitialized().equalsValue(
      this as AlarmState,
      other,
    );
  }

  @override
  int get hashCode {
    return AlarmStateMapper.ensureInitialized().hashValue(this as AlarmState);
  }
}

extension AlarmStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AlarmState, $Out> {
  AlarmStateCopyWith<$R, AlarmState, $Out> get $asAlarmState =>
      $base.as((v, t, t2) => _AlarmStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AlarmStateCopyWith<$R, $In extends AlarmState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Alarm, AlarmCopyWith<$R, Alarm, Alarm>> get alarms;
  $R call({List<Alarm>? alarms});
  AlarmStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AlarmStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AlarmState, $Out>
    implements AlarmStateCopyWith<$R, AlarmState, $Out> {
  _AlarmStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AlarmState> $mapper =
      AlarmStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Alarm, AlarmCopyWith<$R, Alarm, Alarm>> get alarms =>
      ListCopyWith(
        $value.alarms,
        (v, t) => v.copyWith.$chain(t),
        (v) => call(alarms: v),
      );
  @override
  $R call({List<Alarm>? alarms}) =>
      $apply(FieldCopyWithData({if (alarms != null) #alarms: alarms}));
  @override
  AlarmState $make(CopyWithData data) =>
      AlarmState(alarms: data.get(#alarms, or: $value.alarms));

  @override
  AlarmStateCopyWith<$R2, AlarmState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AlarmStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

