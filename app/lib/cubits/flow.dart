import 'package:flow/api/storage/sources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/services/source.dart';
import 'package:collection/collection.dart';

part 'flow.freezed.dart';

@freezed
class FlowState with _$FlowState {
  const factory FlowState({
    @Default([]) List<String> disabledSources,
  }) = _FlowState;
}

class FlowCubit extends Cubit<FlowState> {
  final SourcesService sourcesService;

  FlowCubit(this.sourcesService) : super(const FlowState());

  String getCurrentSource() {
    return getCurrentSources().firstOrNull ?? '';
  }

  List<String> getCurrentSources() {
    return ['']
        .whereNot((source) => state.disabledSources.contains(source))
        .toList();
  }

  SourceService getCurrentService() {
    return sourcesService.local;
  }

  List<SourceService> getCurrentServices() {
    return getCurrentSources().map((e) => getSource(e)).toList();
  }

  void removeSource(String source) {
    emit(state.copyWith(disabledSources: [...state.disabledSources, source]));
  }

  void addSource(String source) {
    emit(state.copyWith(
        disabledSources:
            state.disabledSources.where((s) => s != source).toList()));
  }

  void setSources(List<String> sources) {
    setDisabledSources(
        getCurrentSources().whereNot((e) => sources.contains(e)).toList());
  }

  void setDisabledSources(List<String> sources) {
    emit(state.copyWith(disabledSources: sources));
  }

  SourceService getSource(String source) {
    return sourcesService.local;
  }

  Map<String, SourceService> getCurrentServicesMap() {
    return Map.fromIterables(getCurrentSources(), getCurrentServices());
  }
}
