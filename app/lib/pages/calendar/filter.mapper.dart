// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'filter.dart';

class CalendarFilterMapper extends ClassMapperBase<CalendarFilter> {
  CalendarFilterMapper._();

  static CalendarFilterMapper? _instance;
  static CalendarFilterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CalendarFilterMapper._());
      EventStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CalendarFilter';

  static List<EventStatus> _$hiddenStatuses(CalendarFilter v) =>
      v.hiddenStatuses;
  static const Field<CalendarFilter, List<EventStatus>> _f$hiddenStatuses =
      Field('hiddenStatuses', _$hiddenStatuses,
          opt: true, def: const [EventStatus.draft, EventStatus.cancelled]);
  static String? _$source(CalendarFilter v) => v.source;
  static const Field<CalendarFilter, String> _f$source =
      Field('source', _$source, opt: true);
  static Uint8List? _$group(CalendarFilter v) => v.group;
  static const Field<CalendarFilter, Uint8List> _f$group =
      Field('group', _$group, opt: true);
  static Uint8List? _$event(CalendarFilter v) => v.event;
  static const Field<CalendarFilter, Uint8List> _f$event =
      Field('event', _$event, opt: true);
  static bool _$past(CalendarFilter v) => v.past;
  static const Field<CalendarFilter, bool> _f$past =
      Field('past', _$past, opt: true, def: false);
  static Uint8List? _$resource(CalendarFilter v) => v.resource;
  static const Field<CalendarFilter, Uint8List> _f$resource =
      Field('resource', _$resource, opt: true);

  @override
  final MappableFields<CalendarFilter> fields = const {
    #hiddenStatuses: _f$hiddenStatuses,
    #source: _f$source,
    #group: _f$group,
    #event: _f$event,
    #past: _f$past,
    #resource: _f$resource,
  };

  static CalendarFilter _instantiate(DecodingData data) {
    return CalendarFilter(
        hiddenStatuses: data.dec(_f$hiddenStatuses),
        source: data.dec(_f$source),
        group: data.dec(_f$group),
        event: data.dec(_f$event),
        past: data.dec(_f$past),
        resource: data.dec(_f$resource));
  }

  @override
  final Function instantiate = _instantiate;

  static CalendarFilter fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CalendarFilter>(map);
  }

  static CalendarFilter fromJson(String json) {
    return ensureInitialized().decodeJson<CalendarFilter>(json);
  }
}

mixin CalendarFilterMappable {
  String toJson() {
    return CalendarFilterMapper.ensureInitialized()
        .encodeJson<CalendarFilter>(this as CalendarFilter);
  }

  Map<String, dynamic> toMap() {
    return CalendarFilterMapper.ensureInitialized()
        .encodeMap<CalendarFilter>(this as CalendarFilter);
  }

  CalendarFilterCopyWith<CalendarFilter, CalendarFilter, CalendarFilter>
      get copyWith =>
          _CalendarFilterCopyWithImpl<CalendarFilter, CalendarFilter>(
              this as CalendarFilter, $identity, $identity);
  @override
  String toString() {
    return CalendarFilterMapper.ensureInitialized()
        .stringifyValue(this as CalendarFilter);
  }

  @override
  bool operator ==(Object other) {
    return CalendarFilterMapper.ensureInitialized()
        .equalsValue(this as CalendarFilter, other);
  }

  @override
  int get hashCode {
    return CalendarFilterMapper.ensureInitialized()
        .hashValue(this as CalendarFilter);
  }
}

extension CalendarFilterValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CalendarFilter, $Out> {
  CalendarFilterCopyWith<$R, CalendarFilter, $Out> get $asCalendarFilter =>
      $base.as((v, t, t2) => _CalendarFilterCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CalendarFilterCopyWith<$R, $In extends CalendarFilter, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, EventStatus, ObjectCopyWith<$R, EventStatus, EventStatus>>
      get hiddenStatuses;
  $R call(
      {List<EventStatus>? hiddenStatuses,
      String? source,
      Uint8List? group,
      Uint8List? event,
      bool? past,
      Uint8List? resource});
  CalendarFilterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CalendarFilterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CalendarFilter, $Out>
    implements CalendarFilterCopyWith<$R, CalendarFilter, $Out> {
  _CalendarFilterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CalendarFilter> $mapper =
      CalendarFilterMapper.ensureInitialized();
  @override
  ListCopyWith<$R, EventStatus, ObjectCopyWith<$R, EventStatus, EventStatus>>
      get hiddenStatuses => ListCopyWith(
          $value.hiddenStatuses,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(hiddenStatuses: v));
  @override
  $R call(
          {List<EventStatus>? hiddenStatuses,
          Object? source = $none,
          Object? group = $none,
          Object? event = $none,
          bool? past,
          Object? resource = $none}) =>
      $apply(FieldCopyWithData({
        if (hiddenStatuses != null) #hiddenStatuses: hiddenStatuses,
        if (source != $none) #source: source,
        if (group != $none) #group: group,
        if (event != $none) #event: event,
        if (past != null) #past: past,
        if (resource != $none) #resource: resource
      }));
  @override
  CalendarFilter $make(CopyWithData data) => CalendarFilter(
      hiddenStatuses: data.get(#hiddenStatuses, or: $value.hiddenStatuses),
      source: data.get(#source, or: $value.source),
      group: data.get(#group, or: $value.group),
      event: data.get(#event, or: $value.event),
      past: data.get(#past, or: $value.past),
      resource: data.get(#resource, or: $value.resource));

  @override
  CalendarFilterCopyWith<$R2, CalendarFilter, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CalendarFilterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
