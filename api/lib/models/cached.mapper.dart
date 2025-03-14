// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cached.dart';

class CachedDataMapper extends ClassMapperBase<CachedData> {
  CachedDataMapper._();

  static CachedDataMapper? _instance;
  static CachedDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CachedDataMapper._());
      EventMapper.ensureInitialized();
      NotebookMapper.ensureInitialized();
      CalendarItemMapper.ensureInitialized();
      NoteMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CachedData';

  static DateTime? _$lastUpdated(CachedData v) => v.lastUpdated;
  static const Field<CachedData, DateTime> _f$lastUpdated =
      Field('lastUpdated', _$lastUpdated, opt: true);
  static List<Event> _$events(CachedData v) => v.events;
  static const Field<CachedData, List<Event>> _f$events =
      Field('events', _$events, opt: true, def: const []);
  static List<Notebook> _$notebooks(CachedData v) => v.notebooks;
  static const Field<CachedData, List<Notebook>> _f$notebooks =
      Field('notebooks', _$notebooks, opt: true, def: const []);
  static List<CalendarItem> _$items(CachedData v) => v.items;
  static const Field<CachedData, List<CalendarItem>> _f$items =
      Field('items', _$items, opt: true, def: const []);
  static List<Note> _$notes(CachedData v) => v.notes;
  static const Field<CachedData, List<Note>> _f$notes =
      Field('notes', _$notes, opt: true, def: const []);

  @override
  final MappableFields<CachedData> fields = const {
    #lastUpdated: _f$lastUpdated,
    #events: _f$events,
    #notebooks: _f$notebooks,
    #items: _f$items,
    #notes: _f$notes,
  };

  static CachedData _instantiate(DecodingData data) {
    return CachedData(
        lastUpdated: data.dec(_f$lastUpdated),
        events: data.dec(_f$events),
        notebooks: data.dec(_f$notebooks),
        items: data.dec(_f$items),
        notes: data.dec(_f$notes));
  }

  @override
  final Function instantiate = _instantiate;

  static CachedData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CachedData>(map);
  }

  static CachedData fromJson(String json) {
    return ensureInitialized().decodeJson<CachedData>(json);
  }
}

mixin CachedDataMappable {
  String toJson() {
    return CachedDataMapper.ensureInitialized()
        .encodeJson<CachedData>(this as CachedData);
  }

  Map<String, dynamic> toMap() {
    return CachedDataMapper.ensureInitialized()
        .encodeMap<CachedData>(this as CachedData);
  }

  CachedDataCopyWith<CachedData, CachedData, CachedData> get copyWith =>
      _CachedDataCopyWithImpl<CachedData, CachedData>(
          this as CachedData, $identity, $identity);
  @override
  String toString() {
    return CachedDataMapper.ensureInitialized()
        .stringifyValue(this as CachedData);
  }

  @override
  bool operator ==(Object other) {
    return CachedDataMapper.ensureInitialized()
        .equalsValue(this as CachedData, other);
  }

  @override
  int get hashCode {
    return CachedDataMapper.ensureInitialized().hashValue(this as CachedData);
  }
}

extension CachedDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CachedData, $Out> {
  CachedDataCopyWith<$R, CachedData, $Out> get $asCachedData =>
      $base.as((v, t, t2) => _CachedDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CachedDataCopyWith<$R, $In extends CachedData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Event, EventCopyWith<$R, Event, Event>> get events;
  ListCopyWith<$R, Notebook, NotebookCopyWith<$R, Notebook, Notebook>>
      get notebooks;
  ListCopyWith<$R, CalendarItem, ObjectCopyWith<$R, CalendarItem, CalendarItem>>
      get items;
  ListCopyWith<$R, Note, NoteCopyWith<$R, Note, Note>> get notes;
  $R call(
      {DateTime? lastUpdated,
      List<Event>? events,
      List<Notebook>? notebooks,
      List<CalendarItem>? items,
      List<Note>? notes});
  CachedDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CachedDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CachedData, $Out>
    implements CachedDataCopyWith<$R, CachedData, $Out> {
  _CachedDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CachedData> $mapper =
      CachedDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Event, EventCopyWith<$R, Event, Event>> get events =>
      ListCopyWith($value.events, (v, t) => v.copyWith.$chain(t),
          (v) => call(events: v));
  @override
  ListCopyWith<$R, Notebook, NotebookCopyWith<$R, Notebook, Notebook>>
      get notebooks => ListCopyWith($value.notebooks,
          (v, t) => v.copyWith.$chain(t), (v) => call(notebooks: v));
  @override
  ListCopyWith<$R, CalendarItem, ObjectCopyWith<$R, CalendarItem, CalendarItem>>
      get items => ListCopyWith($value.items,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(items: v));
  @override
  ListCopyWith<$R, Note, NoteCopyWith<$R, Note, Note>> get notes =>
      ListCopyWith(
          $value.notes, (v, t) => v.copyWith.$chain(t), (v) => call(notes: v));
  @override
  $R call(
          {Object? lastUpdated = $none,
          List<Event>? events,
          List<Notebook>? notebooks,
          List<CalendarItem>? items,
          List<Note>? notes}) =>
      $apply(FieldCopyWithData({
        if (lastUpdated != $none) #lastUpdated: lastUpdated,
        if (events != null) #events: events,
        if (notebooks != null) #notebooks: notebooks,
        if (items != null) #items: items,
        if (notes != null) #notes: notes
      }));
  @override
  CachedData $make(CopyWithData data) => CachedData(
      lastUpdated: data.get(#lastUpdated, or: $value.lastUpdated),
      events: data.get(#events, or: $value.events),
      notebooks: data.get(#notebooks, or: $value.notebooks),
      items: data.get(#items, or: $value.items),
      notes: data.get(#notes, or: $value.notes));

  @override
  CachedDataCopyWith<$R2, CachedData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CachedDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
