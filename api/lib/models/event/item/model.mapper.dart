// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class CalendarItemTypeMapper extends EnumMapper<CalendarItemType> {
  CalendarItemTypeMapper._();

  static CalendarItemTypeMapper? _instance;
  static CalendarItemTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CalendarItemTypeMapper._());
    }
    return _instance!;
  }

  static CalendarItemType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  CalendarItemType decode(dynamic value) {
    switch (value) {
      case r'appointment':
        return CalendarItemType.appointment;
      case r'moment':
        return CalendarItemType.moment;
      case r'pending':
        return CalendarItemType.pending;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(CalendarItemType self) {
    switch (self) {
      case CalendarItemType.appointment:
        return r'appointment';
      case CalendarItemType.moment:
        return r'moment';
      case CalendarItemType.pending:
        return r'pending';
    }
  }
}

extension CalendarItemTypeMapperExtension on CalendarItemType {
  String toValue() {
    CalendarItemTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<CalendarItemType>(this) as String;
  }
}

class CalendarItemMapper extends ClassMapperBase<CalendarItem> {
  CalendarItemMapper._();

  static CalendarItemMapper? _instance;
  static CalendarItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CalendarItemMapper._());
      FixedCalendarItemMapper.ensureInitialized();
      RepeatingCalendarItemMapper.ensureInitialized();
      AutoCalendarItemMapper.ensureInitialized();
      EventStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CalendarItem';

  static Uint8List? _$id(CalendarItem v) => v.id;
  static const Field<CalendarItem, Uint8List> _f$id =
      Field('id', _$id, opt: true);
  static String _$name(CalendarItem v) => v.name;
  static const Field<CalendarItem, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(CalendarItem v) => v.description;
  static const Field<CalendarItem, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static String _$location(CalendarItem v) => v.location;
  static const Field<CalendarItem, String> _f$location =
      Field('location', _$location, opt: true, def: '');
  static Uint8List? _$eventId(CalendarItem v) => v.eventId;
  static const Field<CalendarItem, Uint8List> _f$eventId =
      Field('eventId', _$eventId, opt: true);
  static DateTime? _$start(CalendarItem v) => v.start;
  static const Field<CalendarItem, DateTime> _f$start =
      Field('start', _$start, opt: true);
  static DateTime? _$end(CalendarItem v) => v.end;
  static const Field<CalendarItem, DateTime> _f$end =
      Field('end', _$end, opt: true);
  static EventStatus _$status(CalendarItem v) => v.status;
  static const Field<CalendarItem, EventStatus> _f$status =
      Field('status', _$status, opt: true, def: EventStatus.confirmed);

  @override
  final MappableFields<CalendarItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #location: _f$location,
    #eventId: _f$eventId,
    #start: _f$start,
    #end: _f$end,
    #status: _f$status,
  };

  static CalendarItem _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('CalendarItem');
  }

  @override
  final Function instantiate = _instantiate;

  static CalendarItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CalendarItem>(map);
  }

  static CalendarItem fromJson(String json) {
    return ensureInitialized().decodeJson<CalendarItem>(json);
  }
}

mixin CalendarItemMappable {
  String toJson();
  Map<String, dynamic> toMap();
  CalendarItemCopyWith<CalendarItem, CalendarItem, CalendarItem> get copyWith;
}

abstract class CalendarItemCopyWith<$R, $In extends CalendarItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {Uint8List? id,
      String? name,
      String? description,
      String? location,
      Uint8List? eventId,
      DateTime? start,
      DateTime? end,
      EventStatus? status});
  CalendarItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class FixedCalendarItemMapper extends ClassMapperBase<FixedCalendarItem> {
  FixedCalendarItemMapper._();

  static FixedCalendarItemMapper? _instance;
  static FixedCalendarItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FixedCalendarItemMapper._());
      CalendarItemMapper.ensureInitialized();
      EventStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FixedCalendarItem';

  static Uint8List? _$id(FixedCalendarItem v) => v.id;
  static const Field<FixedCalendarItem, Uint8List> _f$id =
      Field('id', _$id, opt: true);
  static String _$name(FixedCalendarItem v) => v.name;
  static const Field<FixedCalendarItem, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(FixedCalendarItem v) => v.description;
  static const Field<FixedCalendarItem, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static String _$location(FixedCalendarItem v) => v.location;
  static const Field<FixedCalendarItem, String> _f$location =
      Field('location', _$location, opt: true, def: '');
  static Uint8List? _$eventId(FixedCalendarItem v) => v.eventId;
  static const Field<FixedCalendarItem, Uint8List> _f$eventId =
      Field('eventId', _$eventId, opt: true);
  static DateTime? _$start(FixedCalendarItem v) => v.start;
  static const Field<FixedCalendarItem, DateTime> _f$start =
      Field('start', _$start, opt: true);
  static DateTime? _$end(FixedCalendarItem v) => v.end;
  static const Field<FixedCalendarItem, DateTime> _f$end =
      Field('end', _$end, opt: true);
  static EventStatus _$status(FixedCalendarItem v) => v.status;
  static const Field<FixedCalendarItem, EventStatus> _f$status =
      Field('status', _$status, opt: true, def: EventStatus.confirmed);

  @override
  final MappableFields<FixedCalendarItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #location: _f$location,
    #eventId: _f$eventId,
    #start: _f$start,
    #end: _f$end,
    #status: _f$status,
  };

  static FixedCalendarItem _instantiate(DecodingData data) {
    return FixedCalendarItem(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        location: data.dec(_f$location),
        eventId: data.dec(_f$eventId),
        start: data.dec(_f$start),
        end: data.dec(_f$end),
        status: data.dec(_f$status));
  }

  @override
  final Function instantiate = _instantiate;

  static FixedCalendarItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FixedCalendarItem>(map);
  }

  static FixedCalendarItem fromJson(String json) {
    return ensureInitialized().decodeJson<FixedCalendarItem>(json);
  }
}

mixin FixedCalendarItemMappable {
  String toJson() {
    return FixedCalendarItemMapper.ensureInitialized()
        .encodeJson<FixedCalendarItem>(this as FixedCalendarItem);
  }

  Map<String, dynamic> toMap() {
    return FixedCalendarItemMapper.ensureInitialized()
        .encodeMap<FixedCalendarItem>(this as FixedCalendarItem);
  }

  FixedCalendarItemCopyWith<FixedCalendarItem, FixedCalendarItem,
          FixedCalendarItem>
      get copyWith =>
          _FixedCalendarItemCopyWithImpl<FixedCalendarItem, FixedCalendarItem>(
              this as FixedCalendarItem, $identity, $identity);
  @override
  String toString() {
    return FixedCalendarItemMapper.ensureInitialized()
        .stringifyValue(this as FixedCalendarItem);
  }

  @override
  bool operator ==(Object other) {
    return FixedCalendarItemMapper.ensureInitialized()
        .equalsValue(this as FixedCalendarItem, other);
  }

  @override
  int get hashCode {
    return FixedCalendarItemMapper.ensureInitialized()
        .hashValue(this as FixedCalendarItem);
  }
}

extension FixedCalendarItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FixedCalendarItem, $Out> {
  FixedCalendarItemCopyWith<$R, FixedCalendarItem, $Out>
      get $asFixedCalendarItem => $base
          .as((v, t, t2) => _FixedCalendarItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FixedCalendarItemCopyWith<$R, $In extends FixedCalendarItem,
    $Out> implements CalendarItemCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {Uint8List? id,
      String? name,
      String? description,
      String? location,
      Uint8List? eventId,
      DateTime? start,
      DateTime? end,
      EventStatus? status});
  FixedCalendarItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FixedCalendarItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FixedCalendarItem, $Out>
    implements FixedCalendarItemCopyWith<$R, FixedCalendarItem, $Out> {
  _FixedCalendarItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FixedCalendarItem> $mapper =
      FixedCalendarItemMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          String? name,
          String? description,
          String? location,
          Object? eventId = $none,
          Object? start = $none,
          Object? end = $none,
          EventStatus? status}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (location != null) #location: location,
        if (eventId != $none) #eventId: eventId,
        if (start != $none) #start: start,
        if (end != $none) #end: end,
        if (status != null) #status: status
      }));
  @override
  FixedCalendarItem $make(CopyWithData data) => FixedCalendarItem(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      location: data.get(#location, or: $value.location),
      eventId: data.get(#eventId, or: $value.eventId),
      start: data.get(#start, or: $value.start),
      end: data.get(#end, or: $value.end),
      status: data.get(#status, or: $value.status));

  @override
  FixedCalendarItemCopyWith<$R2, FixedCalendarItem, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FixedCalendarItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class RepeatingCalendarItemMapper
    extends ClassMapperBase<RepeatingCalendarItem> {
  RepeatingCalendarItemMapper._();

  static RepeatingCalendarItemMapper? _instance;
  static RepeatingCalendarItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RepeatingCalendarItemMapper._());
      CalendarItemMapper.ensureInitialized();
      EventStatusMapper.ensureInitialized();
      RepeatTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RepeatingCalendarItem';

  static Uint8List? _$id(RepeatingCalendarItem v) => v.id;
  static const Field<RepeatingCalendarItem, Uint8List> _f$id =
      Field('id', _$id, opt: true);
  static String _$name(RepeatingCalendarItem v) => v.name;
  static const Field<RepeatingCalendarItem, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(RepeatingCalendarItem v) => v.description;
  static const Field<RepeatingCalendarItem, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static String _$location(RepeatingCalendarItem v) => v.location;
  static const Field<RepeatingCalendarItem, String> _f$location =
      Field('location', _$location, opt: true, def: '');
  static Uint8List? _$eventId(RepeatingCalendarItem v) => v.eventId;
  static const Field<RepeatingCalendarItem, Uint8List> _f$eventId =
      Field('eventId', _$eventId, opt: true);
  static DateTime? _$start(RepeatingCalendarItem v) => v.start;
  static const Field<RepeatingCalendarItem, DateTime> _f$start =
      Field('start', _$start, opt: true);
  static DateTime? _$end(RepeatingCalendarItem v) => v.end;
  static const Field<RepeatingCalendarItem, DateTime> _f$end =
      Field('end', _$end, opt: true);
  static EventStatus _$status(RepeatingCalendarItem v) => v.status;
  static const Field<RepeatingCalendarItem, EventStatus> _f$status =
      Field('status', _$status, opt: true, def: EventStatus.confirmed);
  static RepeatType _$repeatType(RepeatingCalendarItem v) => v.repeatType;
  static const Field<RepeatingCalendarItem, RepeatType> _f$repeatType =
      Field('repeatType', _$repeatType, opt: true, def: RepeatType.daily);
  static int _$interval(RepeatingCalendarItem v) => v.interval;
  static const Field<RepeatingCalendarItem, int> _f$interval =
      Field('interval', _$interval, opt: true, def: 1);
  static int _$variation(RepeatingCalendarItem v) => v.variation;
  static const Field<RepeatingCalendarItem, int> _f$variation =
      Field('variation', _$variation, opt: true, def: 0);
  static int _$count(RepeatingCalendarItem v) => v.count;
  static const Field<RepeatingCalendarItem, int> _f$count =
      Field('count', _$count, opt: true, def: 0);
  static DateTime? _$until(RepeatingCalendarItem v) => v.until;
  static const Field<RepeatingCalendarItem, DateTime> _f$until =
      Field('until', _$until, opt: true);
  static List<int> _$exceptions(RepeatingCalendarItem v) => v.exceptions;
  static const Field<RepeatingCalendarItem, List<int>> _f$exceptions =
      Field('exceptions', _$exceptions, opt: true, def: const []);

  @override
  final MappableFields<RepeatingCalendarItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #location: _f$location,
    #eventId: _f$eventId,
    #start: _f$start,
    #end: _f$end,
    #status: _f$status,
    #repeatType: _f$repeatType,
    #interval: _f$interval,
    #variation: _f$variation,
    #count: _f$count,
    #until: _f$until,
    #exceptions: _f$exceptions,
  };

  static RepeatingCalendarItem _instantiate(DecodingData data) {
    return RepeatingCalendarItem(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        location: data.dec(_f$location),
        eventId: data.dec(_f$eventId),
        start: data.dec(_f$start),
        end: data.dec(_f$end),
        status: data.dec(_f$status),
        repeatType: data.dec(_f$repeatType),
        interval: data.dec(_f$interval),
        variation: data.dec(_f$variation),
        count: data.dec(_f$count),
        until: data.dec(_f$until),
        exceptions: data.dec(_f$exceptions));
  }

  @override
  final Function instantiate = _instantiate;

  static RepeatingCalendarItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RepeatingCalendarItem>(map);
  }

  static RepeatingCalendarItem fromJson(String json) {
    return ensureInitialized().decodeJson<RepeatingCalendarItem>(json);
  }
}

mixin RepeatingCalendarItemMappable {
  String toJson() {
    return RepeatingCalendarItemMapper.ensureInitialized()
        .encodeJson<RepeatingCalendarItem>(this as RepeatingCalendarItem);
  }

  Map<String, dynamic> toMap() {
    return RepeatingCalendarItemMapper.ensureInitialized()
        .encodeMap<RepeatingCalendarItem>(this as RepeatingCalendarItem);
  }

  RepeatingCalendarItemCopyWith<RepeatingCalendarItem, RepeatingCalendarItem,
      RepeatingCalendarItem> get copyWith => _RepeatingCalendarItemCopyWithImpl<
          RepeatingCalendarItem, RepeatingCalendarItem>(
      this as RepeatingCalendarItem, $identity, $identity);
  @override
  String toString() {
    return RepeatingCalendarItemMapper.ensureInitialized()
        .stringifyValue(this as RepeatingCalendarItem);
  }

  @override
  bool operator ==(Object other) {
    return RepeatingCalendarItemMapper.ensureInitialized()
        .equalsValue(this as RepeatingCalendarItem, other);
  }

  @override
  int get hashCode {
    return RepeatingCalendarItemMapper.ensureInitialized()
        .hashValue(this as RepeatingCalendarItem);
  }
}

extension RepeatingCalendarItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RepeatingCalendarItem, $Out> {
  RepeatingCalendarItemCopyWith<$R, RepeatingCalendarItem, $Out>
      get $asRepeatingCalendarItem => $base.as(
          (v, t, t2) => _RepeatingCalendarItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RepeatingCalendarItemCopyWith<
    $R,
    $In extends RepeatingCalendarItem,
    $Out> implements CalendarItemCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get exceptions;
  @override
  $R call(
      {Uint8List? id,
      String? name,
      String? description,
      String? location,
      Uint8List? eventId,
      DateTime? start,
      DateTime? end,
      EventStatus? status,
      RepeatType? repeatType,
      int? interval,
      int? variation,
      int? count,
      DateTime? until,
      List<int>? exceptions});
  RepeatingCalendarItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RepeatingCalendarItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RepeatingCalendarItem, $Out>
    implements RepeatingCalendarItemCopyWith<$R, RepeatingCalendarItem, $Out> {
  _RepeatingCalendarItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RepeatingCalendarItem> $mapper =
      RepeatingCalendarItemMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get exceptions =>
      ListCopyWith($value.exceptions, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(exceptions: v));
  @override
  $R call(
          {Object? id = $none,
          String? name,
          String? description,
          String? location,
          Object? eventId = $none,
          Object? start = $none,
          Object? end = $none,
          EventStatus? status,
          RepeatType? repeatType,
          int? interval,
          int? variation,
          int? count,
          Object? until = $none,
          List<int>? exceptions}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (location != null) #location: location,
        if (eventId != $none) #eventId: eventId,
        if (start != $none) #start: start,
        if (end != $none) #end: end,
        if (status != null) #status: status,
        if (repeatType != null) #repeatType: repeatType,
        if (interval != null) #interval: interval,
        if (variation != null) #variation: variation,
        if (count != null) #count: count,
        if (until != $none) #until: until,
        if (exceptions != null) #exceptions: exceptions
      }));
  @override
  RepeatingCalendarItem $make(CopyWithData data) => RepeatingCalendarItem(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      location: data.get(#location, or: $value.location),
      eventId: data.get(#eventId, or: $value.eventId),
      start: data.get(#start, or: $value.start),
      end: data.get(#end, or: $value.end),
      status: data.get(#status, or: $value.status),
      repeatType: data.get(#repeatType, or: $value.repeatType),
      interval: data.get(#interval, or: $value.interval),
      variation: data.get(#variation, or: $value.variation),
      count: data.get(#count, or: $value.count),
      until: data.get(#until, or: $value.until),
      exceptions: data.get(#exceptions, or: $value.exceptions));

  @override
  RepeatingCalendarItemCopyWith<$R2, RepeatingCalendarItem, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _RepeatingCalendarItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AutoCalendarItemMapper extends ClassMapperBase<AutoCalendarItem> {
  AutoCalendarItemMapper._();

  static AutoCalendarItemMapper? _instance;
  static AutoCalendarItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AutoCalendarItemMapper._());
      CalendarItemMapper.ensureInitialized();
      EventStatusMapper.ensureInitialized();
      RepeatTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AutoCalendarItem';

  static Uint8List? _$id(AutoCalendarItem v) => v.id;
  static const Field<AutoCalendarItem, Uint8List> _f$id =
      Field('id', _$id, opt: true);
  static String _$name(AutoCalendarItem v) => v.name;
  static const Field<AutoCalendarItem, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(AutoCalendarItem v) => v.description;
  static const Field<AutoCalendarItem, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static String _$location(AutoCalendarItem v) => v.location;
  static const Field<AutoCalendarItem, String> _f$location =
      Field('location', _$location, opt: true, def: '');
  static Uint8List? _$eventId(AutoCalendarItem v) => v.eventId;
  static const Field<AutoCalendarItem, Uint8List> _f$eventId =
      Field('eventId', _$eventId, opt: true);
  static EventStatus _$status(AutoCalendarItem v) => v.status;
  static const Field<AutoCalendarItem, EventStatus> _f$status =
      Field('status', _$status, opt: true, def: EventStatus.confirmed);
  static DateTime? _$start(AutoCalendarItem v) => v.start;
  static const Field<AutoCalendarItem, DateTime> _f$start =
      Field('start', _$start, opt: true);
  static DateTime? _$end(AutoCalendarItem v) => v.end;
  static const Field<AutoCalendarItem, DateTime> _f$end =
      Field('end', _$end, opt: true);
  static RepeatType _$repeatType(AutoCalendarItem v) => v.repeatType;
  static const Field<AutoCalendarItem, RepeatType> _f$repeatType =
      Field('repeatType', _$repeatType, opt: true, def: RepeatType.daily);
  static int _$interval(AutoCalendarItem v) => v.interval;
  static const Field<AutoCalendarItem, int> _f$interval =
      Field('interval', _$interval, opt: true, def: 1);
  static int _$variation(AutoCalendarItem v) => v.variation;
  static const Field<AutoCalendarItem, int> _f$variation =
      Field('variation', _$variation, opt: true, def: 0);
  static int _$count(AutoCalendarItem v) => v.count;
  static const Field<AutoCalendarItem, int> _f$count =
      Field('count', _$count, opt: true, def: 0);
  static DateTime? _$until(AutoCalendarItem v) => v.until;
  static const Field<AutoCalendarItem, DateTime> _f$until =
      Field('until', _$until, opt: true);
  static List<int> _$exceptions(AutoCalendarItem v) => v.exceptions;
  static const Field<AutoCalendarItem, List<int>> _f$exceptions =
      Field('exceptions', _$exceptions, opt: true, def: const []);
  static Uint8List? _$autoGroupId(AutoCalendarItem v) => v.autoGroupId;
  static const Field<AutoCalendarItem, Uint8List> _f$autoGroupId =
      Field('autoGroupId', _$autoGroupId, opt: true);
  static DateTime? _$searchStart(AutoCalendarItem v) => v.searchStart;
  static const Field<AutoCalendarItem, DateTime> _f$searchStart =
      Field('searchStart', _$searchStart, opt: true);
  static int _$autoDuration(AutoCalendarItem v) => v.autoDuration;
  static const Field<AutoCalendarItem, int> _f$autoDuration =
      Field('autoDuration', _$autoDuration, opt: true, def: 60);

  @override
  final MappableFields<AutoCalendarItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #location: _f$location,
    #eventId: _f$eventId,
    #status: _f$status,
    #start: _f$start,
    #end: _f$end,
    #repeatType: _f$repeatType,
    #interval: _f$interval,
    #variation: _f$variation,
    #count: _f$count,
    #until: _f$until,
    #exceptions: _f$exceptions,
    #autoGroupId: _f$autoGroupId,
    #searchStart: _f$searchStart,
    #autoDuration: _f$autoDuration,
  };

  static AutoCalendarItem _instantiate(DecodingData data) {
    return AutoCalendarItem(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        location: data.dec(_f$location),
        eventId: data.dec(_f$eventId),
        status: data.dec(_f$status),
        start: data.dec(_f$start),
        end: data.dec(_f$end),
        repeatType: data.dec(_f$repeatType),
        interval: data.dec(_f$interval),
        variation: data.dec(_f$variation),
        count: data.dec(_f$count),
        until: data.dec(_f$until),
        exceptions: data.dec(_f$exceptions),
        autoGroupId: data.dec(_f$autoGroupId),
        searchStart: data.dec(_f$searchStart),
        autoDuration: data.dec(_f$autoDuration));
  }

  @override
  final Function instantiate = _instantiate;

  static AutoCalendarItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AutoCalendarItem>(map);
  }

  static AutoCalendarItem fromJson(String json) {
    return ensureInitialized().decodeJson<AutoCalendarItem>(json);
  }
}

mixin AutoCalendarItemMappable {
  String toJson() {
    return AutoCalendarItemMapper.ensureInitialized()
        .encodeJson<AutoCalendarItem>(this as AutoCalendarItem);
  }

  Map<String, dynamic> toMap() {
    return AutoCalendarItemMapper.ensureInitialized()
        .encodeMap<AutoCalendarItem>(this as AutoCalendarItem);
  }

  AutoCalendarItemCopyWith<AutoCalendarItem, AutoCalendarItem, AutoCalendarItem>
      get copyWith =>
          _AutoCalendarItemCopyWithImpl<AutoCalendarItem, AutoCalendarItem>(
              this as AutoCalendarItem, $identity, $identity);
  @override
  String toString() {
    return AutoCalendarItemMapper.ensureInitialized()
        .stringifyValue(this as AutoCalendarItem);
  }

  @override
  bool operator ==(Object other) {
    return AutoCalendarItemMapper.ensureInitialized()
        .equalsValue(this as AutoCalendarItem, other);
  }

  @override
  int get hashCode {
    return AutoCalendarItemMapper.ensureInitialized()
        .hashValue(this as AutoCalendarItem);
  }
}

extension AutoCalendarItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AutoCalendarItem, $Out> {
  AutoCalendarItemCopyWith<$R, AutoCalendarItem, $Out>
      get $asAutoCalendarItem => $base
          .as((v, t, t2) => _AutoCalendarItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AutoCalendarItemCopyWith<$R, $In extends AutoCalendarItem, $Out>
    implements CalendarItemCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get exceptions;
  @override
  $R call(
      {Uint8List? id,
      String? name,
      String? description,
      String? location,
      Uint8List? eventId,
      EventStatus? status,
      DateTime? start,
      DateTime? end,
      RepeatType? repeatType,
      int? interval,
      int? variation,
      int? count,
      DateTime? until,
      List<int>? exceptions,
      Uint8List? autoGroupId,
      DateTime? searchStart,
      int? autoDuration});
  AutoCalendarItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AutoCalendarItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AutoCalendarItem, $Out>
    implements AutoCalendarItemCopyWith<$R, AutoCalendarItem, $Out> {
  _AutoCalendarItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AutoCalendarItem> $mapper =
      AutoCalendarItemMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get exceptions =>
      ListCopyWith($value.exceptions, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(exceptions: v));
  @override
  $R call(
          {Object? id = $none,
          String? name,
          String? description,
          String? location,
          Object? eventId = $none,
          EventStatus? status,
          Object? start = $none,
          Object? end = $none,
          RepeatType? repeatType,
          int? interval,
          int? variation,
          int? count,
          Object? until = $none,
          List<int>? exceptions,
          Object? autoGroupId = $none,
          Object? searchStart = $none,
          int? autoDuration}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (location != null) #location: location,
        if (eventId != $none) #eventId: eventId,
        if (status != null) #status: status,
        if (start != $none) #start: start,
        if (end != $none) #end: end,
        if (repeatType != null) #repeatType: repeatType,
        if (interval != null) #interval: interval,
        if (variation != null) #variation: variation,
        if (count != null) #count: count,
        if (until != $none) #until: until,
        if (exceptions != null) #exceptions: exceptions,
        if (autoGroupId != $none) #autoGroupId: autoGroupId,
        if (searchStart != $none) #searchStart: searchStart,
        if (autoDuration != null) #autoDuration: autoDuration
      }));
  @override
  AutoCalendarItem $make(CopyWithData data) => AutoCalendarItem(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      location: data.get(#location, or: $value.location),
      eventId: data.get(#eventId, or: $value.eventId),
      status: data.get(#status, or: $value.status),
      start: data.get(#start, or: $value.start),
      end: data.get(#end, or: $value.end),
      repeatType: data.get(#repeatType, or: $value.repeatType),
      interval: data.get(#interval, or: $value.interval),
      variation: data.get(#variation, or: $value.variation),
      count: data.get(#count, or: $value.count),
      until: data.get(#until, or: $value.until),
      exceptions: data.get(#exceptions, or: $value.exceptions),
      autoGroupId: data.get(#autoGroupId, or: $value.autoGroupId),
      searchStart: data.get(#searchStart, or: $value.searchStart),
      autoDuration: data.get(#autoDuration, or: $value.autoDuration));

  @override
  AutoCalendarItemCopyWith<$R2, AutoCalendarItem, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AutoCalendarItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
