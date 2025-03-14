// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'flow.dart';

class FlowStateMapper extends ClassMapperBase<FlowState> {
  FlowStateMapper._();

  static FlowStateMapper? _instance;
  static FlowStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FlowStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FlowState';

  static List<String> _$disabledSources(FlowState v) => v.disabledSources;
  static const Field<FlowState, List<String>> _f$disabledSources =
      Field('disabledSources', _$disabledSources, opt: true, def: const []);

  @override
  final MappableFields<FlowState> fields = const {
    #disabledSources: _f$disabledSources,
  };

  static FlowState _instantiate(DecodingData data) {
    return FlowState(disabledSources: data.dec(_f$disabledSources));
  }

  @override
  final Function instantiate = _instantiate;

  static FlowState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FlowState>(map);
  }

  static FlowState fromJson(String json) {
    return ensureInitialized().decodeJson<FlowState>(json);
  }
}

mixin FlowStateMappable {
  String toJson() {
    return FlowStateMapper.ensureInitialized()
        .encodeJson<FlowState>(this as FlowState);
  }

  Map<String, dynamic> toMap() {
    return FlowStateMapper.ensureInitialized()
        .encodeMap<FlowState>(this as FlowState);
  }

  FlowStateCopyWith<FlowState, FlowState, FlowState> get copyWith =>
      _FlowStateCopyWithImpl<FlowState, FlowState>(
          this as FlowState, $identity, $identity);
  @override
  String toString() {
    return FlowStateMapper.ensureInitialized()
        .stringifyValue(this as FlowState);
  }

  @override
  bool operator ==(Object other) {
    return FlowStateMapper.ensureInitialized()
        .equalsValue(this as FlowState, other);
  }

  @override
  int get hashCode {
    return FlowStateMapper.ensureInitialized().hashValue(this as FlowState);
  }
}

extension FlowStateValueCopy<$R, $Out> on ObjectCopyWith<$R, FlowState, $Out> {
  FlowStateCopyWith<$R, FlowState, $Out> get $asFlowState =>
      $base.as((v, t, t2) => _FlowStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class FlowStateCopyWith<$R, $In extends FlowState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get disabledSources;
  $R call({List<String>? disabledSources});
  FlowStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FlowStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FlowState, $Out>
    implements FlowStateCopyWith<$R, FlowState, $Out> {
  _FlowStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FlowState> $mapper =
      FlowStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get disabledSources => ListCopyWith(
          $value.disabledSources,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(disabledSources: v));
  @override
  $R call({List<String>? disabledSources}) => $apply(FieldCopyWithData(
      {if (disabledSources != null) #disabledSources: disabledSources}));
  @override
  FlowState $make(CopyWithData data) => FlowState(
      disabledSources: data.get(#disabledSources, or: $value.disabledSources));

  @override
  FlowStateCopyWith<$R2, FlowState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FlowStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
