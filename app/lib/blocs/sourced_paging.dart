import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/services/source.dart';

part 'sourced_paging_event.dart';
part 'sourced_paging_state.dart';

part 'sourced_paging.mapper.dart';

class SourcedPagingBloc<T>
    extends Bloc<SourcedPagingEvent, SourcedPagingState<T>> {
  final FlowCubit cubit;
  final int pageSize;
  final Future<List<T>?> Function(
    String source,
    SourceService service,
    int offset,
    int limit,
  ) _fetch;

  SourcedPagingBloc(
      {required this.cubit,
      required Future<List<T>?> Function(String, SourceService, int, int) fetch,
      this.pageSize = 50})
      : _fetch = fetch,
        super(const SourcedPagingInitial()) {
    on<SourcedPagingFetched<T>>(_onFetched);
  }

  Future<void> _onFetched(
    SourcedPagingFetched<T> event,
    Emitter<SourcedPagingState<T>> emit,
  ) async {
    final state = this.state;
    if (state.hasReachedMax) return;

    try {
      final currentPageKey = state.currentPageKey ??
          SourcedModel(cubit.getCurrentSources().first, 0);
      final previousItems = state is SourcedPagingSuccess<T> ? state.items : [];

      final fetchedItems = (await _fetch(
                  currentPageKey.source,
                  cubit.getService(currentPageKey.source),
                  currentPageKey.model * pageSize,
                  pageSize) ??
              <T>[])
          .map((e) => SourcedModel(currentPageKey.source, e))
          .toList();

      final sources = cubit.getCurrentSources();
      final currentSourceIndex = sources.indexOf(currentPageKey.source);
      final keepSource = fetchedItems.length >= pageSize;
      final isLastSource = currentSourceIndex >= sources.length - 1;

      if (isLastSource && !keepSource) {
        emit(SourcedPagingSuccess(
          currentPageKey: currentPageKey,
          items: [...previousItems, ...fetchedItems],
          hasReachedMax: true,
        ));
      } else if (keepSource) {
        emit(SourcedPagingSuccess(
          items: [...previousItems, ...fetchedItems],
          currentPageKey: SourcedModel(
            currentPageKey.source,
            currentPageKey.model + 1,
          ),
        ));
      } else {
        final nextSource = sources[currentSourceIndex + 1];
        emit(SourcedPagingSuccess(
          items: [...previousItems, ...fetchedItems],
          currentPageKey: SourcedModel(nextSource, 0),
        ));
      }
    } catch (e) {
      emit(SourcedPagingFailure(e));
    }
  }

  void refresh() => add(SourcedPagingRefresh());
  void fetch() => add(SourcedPagingFetched<T>());
}
