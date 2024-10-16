// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NoteFilter {
  bool get showDone => throw _privateConstructorUsedError;
  bool get showInProgress => throw _privateConstructorUsedError;
  bool get showTodo => throw _privateConstructorUsedError;
  bool get showNote => throw _privateConstructorUsedError;
  Multihash? get selectedLabel => throw _privateConstructorUsedError;
  Multihash? get notebook => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteFilterCopyWith<NoteFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteFilterCopyWith<$Res> {
  factory $NoteFilterCopyWith(
          NoteFilter value, $Res Function(NoteFilter) then) =
      _$NoteFilterCopyWithImpl<$Res, NoteFilter>;
  @useResult
  $Res call(
      {bool showDone,
      bool showInProgress,
      bool showTodo,
      bool showNote,
      Multihash? selectedLabel,
      Multihash? notebook,
      String? source});
}

/// @nodoc
class _$NoteFilterCopyWithImpl<$Res, $Val extends NoteFilter>
    implements $NoteFilterCopyWith<$Res> {
  _$NoteFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showDone = null,
    Object? showInProgress = null,
    Object? showTodo = null,
    Object? showNote = null,
    Object? selectedLabel = freezed,
    Object? notebook = freezed,
    Object? source = freezed,
  }) {
    return _then(_value.copyWith(
      showDone: null == showDone
          ? _value.showDone
          : showDone // ignore: cast_nullable_to_non_nullable
              as bool,
      showInProgress: null == showInProgress
          ? _value.showInProgress
          : showInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      showTodo: null == showTodo
          ? _value.showTodo
          : showTodo // ignore: cast_nullable_to_non_nullable
              as bool,
      showNote: null == showNote
          ? _value.showNote
          : showNote // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedLabel: freezed == selectedLabel
          ? _value.selectedLabel
          : selectedLabel // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      notebook: freezed == notebook
          ? _value.notebook
          : notebook // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteFilterImplCopyWith<$Res>
    implements $NoteFilterCopyWith<$Res> {
  factory _$$NoteFilterImplCopyWith(
          _$NoteFilterImpl value, $Res Function(_$NoteFilterImpl) then) =
      __$$NoteFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool showDone,
      bool showInProgress,
      bool showTodo,
      bool showNote,
      Multihash? selectedLabel,
      Multihash? notebook,
      String? source});
}

/// @nodoc
class __$$NoteFilterImplCopyWithImpl<$Res>
    extends _$NoteFilterCopyWithImpl<$Res, _$NoteFilterImpl>
    implements _$$NoteFilterImplCopyWith<$Res> {
  __$$NoteFilterImplCopyWithImpl(
      _$NoteFilterImpl _value, $Res Function(_$NoteFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showDone = null,
    Object? showInProgress = null,
    Object? showTodo = null,
    Object? showNote = null,
    Object? selectedLabel = freezed,
    Object? notebook = freezed,
    Object? source = freezed,
  }) {
    return _then(_$NoteFilterImpl(
      showDone: null == showDone
          ? _value.showDone
          : showDone // ignore: cast_nullable_to_non_nullable
              as bool,
      showInProgress: null == showInProgress
          ? _value.showInProgress
          : showInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      showTodo: null == showTodo
          ? _value.showTodo
          : showTodo // ignore: cast_nullable_to_non_nullable
              as bool,
      showNote: null == showNote
          ? _value.showNote
          : showNote // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedLabel: freezed == selectedLabel
          ? _value.selectedLabel
          : selectedLabel // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      notebook: freezed == notebook
          ? _value.notebook
          : notebook // ignore: cast_nullable_to_non_nullable
              as Multihash?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NoteFilterImpl extends _NoteFilter {
  const _$NoteFilterImpl(
      {this.showDone = true,
      this.showInProgress = true,
      this.showTodo = true,
      this.showNote = true,
      this.selectedLabel,
      this.notebook,
      this.source})
      : super._();

  @override
  @JsonKey()
  final bool showDone;
  @override
  @JsonKey()
  final bool showInProgress;
  @override
  @JsonKey()
  final bool showTodo;
  @override
  @JsonKey()
  final bool showNote;
  @override
  final Multihash? selectedLabel;
  @override
  final Multihash? notebook;
  @override
  final String? source;

  @override
  String toString() {
    return 'NoteFilter(showDone: $showDone, showInProgress: $showInProgress, showTodo: $showTodo, showNote: $showNote, selectedLabel: $selectedLabel, notebook: $notebook, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteFilterImpl &&
            (identical(other.showDone, showDone) ||
                other.showDone == showDone) &&
            (identical(other.showInProgress, showInProgress) ||
                other.showInProgress == showInProgress) &&
            (identical(other.showTodo, showTodo) ||
                other.showTodo == showTodo) &&
            (identical(other.showNote, showNote) ||
                other.showNote == showNote) &&
            (identical(other.selectedLabel, selectedLabel) ||
                other.selectedLabel == selectedLabel) &&
            (identical(other.notebook, notebook) ||
                other.notebook == notebook) &&
            (identical(other.source, source) || other.source == source));
  }

  @override
  int get hashCode => Object.hash(runtimeType, showDone, showInProgress,
      showTodo, showNote, selectedLabel, notebook, source);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteFilterImplCopyWith<_$NoteFilterImpl> get copyWith =>
      __$$NoteFilterImplCopyWithImpl<_$NoteFilterImpl>(this, _$identity);
}

abstract class _NoteFilter extends NoteFilter {
  const factory _NoteFilter(
      {final bool showDone,
      final bool showInProgress,
      final bool showTodo,
      final bool showNote,
      final Multihash? selectedLabel,
      final Multihash? notebook,
      final String? source}) = _$NoteFilterImpl;
  const _NoteFilter._() : super._();

  @override
  bool get showDone;
  @override
  bool get showInProgress;
  @override
  bool get showTodo;
  @override
  bool get showNote;
  @override
  Multihash? get selectedLabel;
  @override
  Multihash? get notebook;
  @override
  String? get source;
  @override
  @JsonKey(ignore: true)
  _$$NoteFilterImplCopyWith<_$NoteFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
