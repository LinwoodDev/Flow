// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'model.dart';

class NoteStatusMapper extends EnumMapper<NoteStatus> {
  NoteStatusMapper._();

  static NoteStatusMapper? _instance;
  static NoteStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteStatusMapper._());
    }
    return _instance!;
  }

  static NoteStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  NoteStatus decode(dynamic value) {
    switch (value) {
      case r'todo':
        return NoteStatus.todo;
      case r'inProgress':
        return NoteStatus.inProgress;
      case r'done':
        return NoteStatus.done;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(NoteStatus self) {
    switch (self) {
      case NoteStatus.todo:
        return r'todo';
      case NoteStatus.inProgress:
        return r'inProgress';
      case NoteStatus.done:
        return r'done';
    }
  }
}

extension NoteStatusMapperExtension on NoteStatus {
  String toValue() {
    NoteStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<NoteStatus>(this) as String;
  }
}

class NotebookMapper extends ClassMapperBase<Notebook> {
  NotebookMapper._();

  static NotebookMapper? _instance;
  static NotebookMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NotebookMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Notebook';

  static Uint8List? _$id(Notebook v) => v.id;
  static const Field<Notebook, Uint8List> _f$id = Field('id', _$id, opt: true);
  static String _$name(Notebook v) => v.name;
  static const Field<Notebook, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(Notebook v) => v.description;
  static const Field<Notebook, String> _f$description =
      Field('description', _$description, opt: true, def: '');

  @override
  final MappableFields<Notebook> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
  };

  static Notebook _instantiate(DecodingData data) {
    return Notebook(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static Notebook fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Notebook>(map);
  }

  static Notebook fromJson(String json) {
    return ensureInitialized().decodeJson<Notebook>(json);
  }
}

mixin NotebookMappable {
  String toJson() {
    return NotebookMapper.ensureInitialized()
        .encodeJson<Notebook>(this as Notebook);
  }

  Map<String, dynamic> toMap() {
    return NotebookMapper.ensureInitialized()
        .encodeMap<Notebook>(this as Notebook);
  }

  NotebookCopyWith<Notebook, Notebook, Notebook> get copyWith =>
      _NotebookCopyWithImpl<Notebook, Notebook>(
          this as Notebook, $identity, $identity);
  @override
  String toString() {
    return NotebookMapper.ensureInitialized().stringifyValue(this as Notebook);
  }

  @override
  bool operator ==(Object other) {
    return NotebookMapper.ensureInitialized()
        .equalsValue(this as Notebook, other);
  }

  @override
  int get hashCode {
    return NotebookMapper.ensureInitialized().hashValue(this as Notebook);
  }
}

extension NotebookValueCopy<$R, $Out> on ObjectCopyWith<$R, Notebook, $Out> {
  NotebookCopyWith<$R, Notebook, $Out> get $asNotebook =>
      $base.as((v, t, t2) => _NotebookCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NotebookCopyWith<$R, $In extends Notebook, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Uint8List? id, String? name, String? description});
  NotebookCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NotebookCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Notebook, $Out>
    implements NotebookCopyWith<$R, Notebook, $Out> {
  _NotebookCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Notebook> $mapper =
      NotebookMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, String? name, String? description}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != null) #name: name,
        if (description != null) #description: description
      }));
  @override
  Notebook $make(CopyWithData data) => Notebook(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description));

  @override
  NotebookCopyWith<$R2, Notebook, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NotebookCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class NoteMapper extends ClassMapperBase<Note> {
  NoteMapper._();

  static NoteMapper? _instance;
  static NoteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteMapper._());
      NoteStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Note';

  static Uint8List? _$notebookId(Note v) => v.notebookId;
  static const Field<Note, Uint8List> _f$notebookId =
      Field('notebookId', _$notebookId, opt: true);
  static Uint8List? _$id(Note v) => v.id;
  static const Field<Note, Uint8List> _f$id = Field('id', _$id, opt: true);
  static Uint8List? _$parentId(Note v) => v.parentId;
  static const Field<Note, Uint8List> _f$parentId =
      Field('parentId', _$parentId, opt: true);
  static String _$name(Note v) => v.name;
  static const Field<Note, String> _f$name =
      Field('name', _$name, opt: true, def: '');
  static String _$description(Note v) => v.description;
  static const Field<Note, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static NoteStatus? _$status(Note v) => v.status;
  static const Field<Note, NoteStatus> _f$status =
      Field('status', _$status, opt: true);
  static int _$priority(Note v) => v.priority;
  static const Field<Note, int> _f$priority =
      Field('priority', _$priority, opt: true, def: 0);

  @override
  final MappableFields<Note> fields = const {
    #notebookId: _f$notebookId,
    #id: _f$id,
    #parentId: _f$parentId,
    #name: _f$name,
    #description: _f$description,
    #status: _f$status,
    #priority: _f$priority,
  };

  static Note _instantiate(DecodingData data) {
    return Note(
        notebookId: data.dec(_f$notebookId),
        id: data.dec(_f$id),
        parentId: data.dec(_f$parentId),
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        status: data.dec(_f$status),
        priority: data.dec(_f$priority));
  }

  @override
  final Function instantiate = _instantiate;

  static Note fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Note>(map);
  }

  static Note fromJson(String json) {
    return ensureInitialized().decodeJson<Note>(json);
  }
}

mixin NoteMappable {
  String toJson() {
    return NoteMapper.ensureInitialized().encodeJson<Note>(this as Note);
  }

  Map<String, dynamic> toMap() {
    return NoteMapper.ensureInitialized().encodeMap<Note>(this as Note);
  }

  NoteCopyWith<Note, Note, Note> get copyWith =>
      _NoteCopyWithImpl<Note, Note>(this as Note, $identity, $identity);
  @override
  String toString() {
    return NoteMapper.ensureInitialized().stringifyValue(this as Note);
  }

  @override
  bool operator ==(Object other) {
    return NoteMapper.ensureInitialized().equalsValue(this as Note, other);
  }

  @override
  int get hashCode {
    return NoteMapper.ensureInitialized().hashValue(this as Note);
  }
}

extension NoteValueCopy<$R, $Out> on ObjectCopyWith<$R, Note, $Out> {
  NoteCopyWith<$R, Note, $Out> get $asNote =>
      $base.as((v, t, t2) => _NoteCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class NoteCopyWith<$R, $In extends Note, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {Uint8List? notebookId,
      Uint8List? id,
      Uint8List? parentId,
      String? name,
      String? description,
      NoteStatus? status,
      int? priority});
  NoteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NoteCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Note, $Out>
    implements NoteCopyWith<$R, Note, $Out> {
  _NoteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Note> $mapper = NoteMapper.ensureInitialized();
  @override
  $R call(
          {Object? notebookId = $none,
          Object? id = $none,
          Object? parentId = $none,
          String? name,
          String? description,
          Object? status = $none,
          int? priority}) =>
      $apply(FieldCopyWithData({
        if (notebookId != $none) #notebookId: notebookId,
        if (id != $none) #id: id,
        if (parentId != $none) #parentId: parentId,
        if (name != null) #name: name,
        if (description != null) #description: description,
        if (status != $none) #status: status,
        if (priority != null) #priority: priority
      }));
  @override
  Note $make(CopyWithData data) => Note(
      notebookId: data.get(#notebookId, or: $value.notebookId),
      id: data.get(#id, or: $value.id),
      parentId: data.get(#parentId, or: $value.parentId),
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      status: data.get(#status, or: $value.status),
      priority: data.get(#priority, or: $value.priority));

  @override
  NoteCopyWith<$R2, Note, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NoteCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
