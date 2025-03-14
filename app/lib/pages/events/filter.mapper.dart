// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'filter.dart';

class EventFilterMapper extends ClassMapperBase<EventFilter> {
  EventFilterMapper._();

  static EventFilterMapper? _instance;
  static EventFilterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventFilterMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'EventFilter';

  static String? _$source(EventFilter v) => v.source;
  static const Field<EventFilter, String> _f$source =
      Field('source', _$source, opt: true);
  static Uint8List? _$group(EventFilter v) => v.group;
  static const Field<EventFilter, Uint8List> _f$group =
      Field('group', _$group, opt: true);
  static Uint8List? _$resource(EventFilter v) => v.resource;
  static const Field<EventFilter, Uint8List> _f$resource =
      Field('resource', _$resource, opt: true);

  @override
  final MappableFields<EventFilter> fields = const {
    #source: _f$source,
    #group: _f$group,
    #resource: _f$resource,
  };

  static EventFilter _instantiate(DecodingData data) {
    return EventFilter(
        source: data.dec(_f$source),
        group: data.dec(_f$group),
        resource: data.dec(_f$resource));
  }

  @override
  final Function instantiate = _instantiate;

  static EventFilter fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<EventFilter>(map);
  }

  static EventFilter fromJson(String json) {
    return ensureInitialized().decodeJson<EventFilter>(json);
  }
}

mixin EventFilterMappable {
  String toJson() {
    return EventFilterMapper.ensureInitialized()
        .encodeJson<EventFilter>(this as EventFilter);
  }

  Map<String, dynamic> toMap() {
    return EventFilterMapper.ensureInitialized()
        .encodeMap<EventFilter>(this as EventFilter);
  }

  EventFilterCopyWith<EventFilter, EventFilter, EventFilter> get copyWith =>
      _EventFilterCopyWithImpl<EventFilter, EventFilter>(
          this as EventFilter, $identity, $identity);
  @override
  String toString() {
    return EventFilterMapper.ensureInitialized()
        .stringifyValue(this as EventFilter);
  }

  @override
  bool operator ==(Object other) {
    return EventFilterMapper.ensureInitialized()
        .equalsValue(this as EventFilter, other);
  }

  @override
  int get hashCode {
    return EventFilterMapper.ensureInitialized().hashValue(this as EventFilter);
  }
}

extension EventFilterValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EventFilter, $Out> {
  EventFilterCopyWith<$R, EventFilter, $Out> get $asEventFilter =>
      $base.as((v, t, t2) => _EventFilterCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventFilterCopyWith<$R, $In extends EventFilter, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? source, Uint8List? group, Uint8List? resource});
  EventFilterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventFilterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EventFilter, $Out>
    implements EventFilterCopyWith<$R, EventFilter, $Out> {
  _EventFilterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EventFilter> $mapper =
      EventFilterMapper.ensureInitialized();
  @override
  $R call(
          {Object? source = $none,
          Object? group = $none,
          Object? resource = $none}) =>
      $apply(FieldCopyWithData({
        if (source != $none) #source: source,
        if (group != $none) #group: group,
        if (resource != $none) #resource: resource
      }));
  @override
  EventFilter $make(CopyWithData data) => EventFilter(
      source: data.get(#source, or: $value.source),
      group: data.get(#group, or: $value.group),
      resource: data.get(#resource, or: $value.resource));

  @override
  EventFilterCopyWith<$R2, EventFilter, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EventFilterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
