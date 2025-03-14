// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'filter.dart';

class NoteFilterMapper extends ClassMapperBase<NoteFilter> {
  NoteFilterMapper._();

  static NoteFilterMapper? _instance;
  static NoteFilterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteFilterMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'NoteFilter';

  static bool _$showDone(NoteFilter v) => v.showDone;
  static const Field<NoteFilter, bool> _f$showDone =
      Field('showDone', _$showDone, opt: true, def: true);
  static bool _$showInProgress(NoteFilter v) => v.showInProgress;
  static const Field<NoteFilter, bool> _f$showInProgress =
      Field('showInProgress', _$showInProgress, opt: true, def: true);
  static bool _$showTodo(NoteFilter v) => v.showTodo;
  static const Field<NoteFilter, bool> _f$showTodo =
      Field('showTodo', _$showTodo, opt: true, def: true);
  static bool _$showNote(NoteFilter v) => v.showNote;
  static const Field<NoteFilter, bool> _f$showNote =
      Field('showNote', _$showNote, opt: true, def: true);
  static Uint8List? _$selectedLabel(NoteFilter v) => v.selectedLabel;
  static const Field<NoteFilter, Uint8List> _f$selectedLabel =
      Field('selectedLabel', _$selectedLabel, opt: true);
  static Uint8List? _$notebook(NoteFilter v) => v.notebook;
  static const Field<NoteFilter, Uint8List> _f$notebook =
      Field('notebook', _$notebook, opt: true);
  static String? _$source(NoteFilter v) => v.source;
  static const Field<NoteFilter, String> _f$source =
      Field('source', _$source, opt: true);

  @override
  final MappableFields<NoteFilter> fields = const {
    #showDone: _f$showDone,
    #showInProgress: _f$showInProgress,
    #showTodo: _f$showTodo,
    #showNote: _f$showNote,
    #selectedLabel: _f$selectedLabel,
    #notebook: _f$notebook,
    #source: _f$source,
  };

  static NoteFilter _instantiate(DecodingData data) {
    return NoteFilter(
        showDone: data.dec(_f$showDone),
        showInProgress: data.dec(_f$showInProgress),
        showTodo: data.dec(_f$showTodo),
        showNote: data.dec(_f$showNote),
        selectedLabel: data.dec(_f$selectedLabel),
        notebook: data.dec(_f$notebook),
        source: data.dec(_f$source));
  }

  @override
  final Function instantiate = _instantiate;

  static NoteFilter fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NoteFilter>(map);
  }

  static NoteFilter fromJson(String json) {
    return ensureInitialized().decodeJson<NoteFilter>(json);
  }
}

mixin NoteFilterMappable {
  String toJson() {
    return NoteFilterMapper.ensureInitialized()
        .encodeJson<NoteFilter>(this as NoteFilter);
  }

  Map<String, dynamic> toMap() {
    return NoteFilterMapper.ensureInitialized()
        .encodeMap<NoteFilter>(this as NoteFilter);
  }

  NoteFilterCopyWith<NoteFilter, NoteFilter, NoteFilter> get copyWith =>
      _NoteFilterCopyWithImpl<NoteFilter, NoteFilter>(
          this as NoteFilter, $identity, $identity);
  @override
  String toString() {
    return NoteFilterMapper.ensureInitialized()
        .stringifyValue(this as NoteFilter);
  }

  @override
  bool operator ==(Object other) {
    return NoteFilterMapper.ensureInitialized()
        .equalsValue(this as NoteFilter, other);
  }

  @override
  int get hashCode {
    return NoteFilterMapper.ensureInitialized().hashValue(this as NoteFilter);
  }
}

extension NoteFilterValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NoteFilter, $Out> {
  NoteFilterCopyWith<$R, NoteFilter, $Out> get $asNoteFilter =>
      $base.as((v, t, t2) => _NoteFilterCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NoteFilterCopyWith<$R, $In extends NoteFilter, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {bool? showDone,
      bool? showInProgress,
      bool? showTodo,
      bool? showNote,
      Uint8List? selectedLabel,
      Uint8List? notebook,
      String? source});
  NoteFilterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NoteFilterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NoteFilter, $Out>
    implements NoteFilterCopyWith<$R, NoteFilter, $Out> {
  _NoteFilterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NoteFilter> $mapper =
      NoteFilterMapper.ensureInitialized();
  @override
  $R call(
          {bool? showDone,
          bool? showInProgress,
          bool? showTodo,
          bool? showNote,
          Object? selectedLabel = $none,
          Object? notebook = $none,
          Object? source = $none}) =>
      $apply(FieldCopyWithData({
        if (showDone != null) #showDone: showDone,
        if (showInProgress != null) #showInProgress: showInProgress,
        if (showTodo != null) #showTodo: showTodo,
        if (showNote != null) #showNote: showNote,
        if (selectedLabel != $none) #selectedLabel: selectedLabel,
        if (notebook != $none) #notebook: notebook,
        if (source != $none) #source: source
      }));
  @override
  NoteFilter $make(CopyWithData data) => NoteFilter(
      showDone: data.get(#showDone, or: $value.showDone),
      showInProgress: data.get(#showInProgress, or: $value.showInProgress),
      showTodo: data.get(#showTodo, or: $value.showTodo),
      showNote: data.get(#showNote, or: $value.showNote),
      selectedLabel: data.get(#selectedLabel, or: $value.selectedLabel),
      notebook: data.get(#notebook, or: $value.notebook),
      source: data.get(#source, or: $value.source));

  @override
  NoteFilterCopyWith<$R2, NoteFilter, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NoteFilterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
