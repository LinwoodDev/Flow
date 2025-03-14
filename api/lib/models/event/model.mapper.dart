// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class EventStatusMapper extends EnumMapper<EventStatus> {
  EventStatusMapper._();

  static EventStatusMapper? _instance;
  static EventStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventStatusMapper._());
    }
    return _instance!;
  }

  static EventStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  EventStatus decode(dynamic value) {
    switch (value) {
      case r'confirmed':
        return EventStatus.confirmed;
      case r'draft':
        return EventStatus.draft;
      case r'cancelled':
        return EventStatus.cancelled;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(EventStatus self) {
    switch (self) {
      case EventStatus.confirmed:
        return r'confirmed';
      case EventStatus.draft:
        return r'draft';
      case EventStatus.cancelled:
        return r'cancelled';
    }
  }
}

extension EventStatusMapperExtension on EventStatus {
  String toValue() {
    EventStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<EventStatus>(this) as String;
  }
}

class RepeatTypeMapper extends EnumMapper<RepeatType> {
  RepeatTypeMapper._();

  static RepeatTypeMapper? _instance;
  static RepeatTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RepeatTypeMapper._());
    }
    return _instance!;
  }

  static RepeatType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  RepeatType decode(dynamic value) {
    switch (value) {
      case r'daily':
        return RepeatType.daily;
      case r'weekly':
        return RepeatType.weekly;
      case r'monthly':
        return RepeatType.monthly;
      case r'yearly':
        return RepeatType.yearly;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(RepeatType self) {
    switch (self) {
      case RepeatType.daily:
        return r'daily';
      case RepeatType.weekly:
        return r'weekly';
      case RepeatType.monthly:
        return r'monthly';
      case RepeatType.yearly:
        return r'yearly';
    }
  }
}

extension RepeatTypeMapperExtension on RepeatType {
  String toValue() {
    RepeatTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<RepeatType>(this) as String;
  }
}

class EventMapper extends ClassMapperBase<Event> {
  EventMapper._();

  static EventMapper? _instance;
  static EventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EventMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Event';

  static Uint8List? _$id(Event v) => v.id;
  static const Field<Event, Uint8List> _f$id = Field('id', _$id, opt: true);
  static Uint8List? _$parentId(Event v) => v.parentId;
  static const Field<Event, Uint8List> _f$parentId =
      Field('parentId', _$parentId, opt: true);
  static bool _$blocked(Event v) => v.blocked;
  static const Field<Event, bool> _f$blocked =
      Field('blocked', _$blocked, opt: true, def: true);
  static String _$name(Event v) => v.name;
  static const Field<Event, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(Event v) => v.description;
  static const Field<Event, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static String _$location(Event v) => v.location;
  static const Field<Event, String> _f$location =
      Field('location', _$location, opt: true, def: '');
  static String? _$extra(Event v) => v.extra;
  static const Field<Event, String> _f$extra =
      Field('extra', _$extra, opt: true);

  @override
  final MappableFields<Event> fields = const {
    #id: _f$id,
    #parentId: _f$parentId,
    #blocked: _f$blocked,
    #name: _f$name,
    #description: _f$description,
    #location: _f$location,
    #extra: _f$extra,
  };

  static Event _instantiate(DecodingData data) {
    return Event(
        id: data.dec(_f$id),
        parentId: data.dec(_f$parentId),
        blocked: data.dec(_f$blocked),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        location: data.dec(_f$location),
        extra: data.dec(_f$extra));
  }

  @override
  final Function instantiate = _instantiate;

  static Event fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Event>(map);
  }

  static Event fromJson(String json) {
    return ensureInitialized().decodeJson<Event>(json);
  }
}

mixin EventMappable {
  String toJson() {
    return EventMapper.ensureInitialized().encodeJson<Event>(this as Event);
  }

  Map<String, dynamic> toMap() {
    return EventMapper.ensureInitialized().encodeMap<Event>(this as Event);
  }

  EventCopyWith<Event, Event, Event> get copyWith =>
      _EventCopyWithImpl<Event, Event>(this as Event, $identity, $identity);
  @override
  String toString() {
    return EventMapper.ensureInitialized().stringifyValue(this as Event);
  }

  @override
  bool operator ==(Object other) {
    return EventMapper.ensureInitialized().equalsValue(this as Event, other);
  }

  @override
  int get hashCode {
    return EventMapper.ensureInitialized().hashValue(this as Event);
  }
}

extension EventValueCopy<$R, $Out> on ObjectCopyWith<$R, Event, $Out> {
  EventCopyWith<$R, Event, $Out> get $asEvent =>
      $base.as((v, t, t2) => _EventCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EventCopyWith<$R, $In extends Event, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {Uint8List? id,
      Uint8List? parentId,
      bool? blocked,
      String? name,
      String? description,
      String? location,
      String? extra});
  EventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EventCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Event, $Out>
    implements EventCopyWith<$R, Event, $Out> {
  _EventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Event> $mapper = EventMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? parentId = $none,
          bool? blocked,
          String? name,
          String? description,
          String? location,
          Object? extra = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (parentId != $none) #parentId: parentId,
        if (blocked != null) #blocked: blocked,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (location != null) #location: location,
        if (extra != $none) #extra: extra
      }));
  @override
  Event $make(CopyWithData data) => Event(
      id: data.get(#id, or: $value.id),
      parentId: data.get(#parentId, or: $value.parentId),
      blocked: data.get(#blocked, or: $value.blocked),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      location: data.get(#location, or: $value.location),
      extra: data.get(#extra, or: $value.extra));

  @override
  EventCopyWith<$R2, Event, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _EventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
