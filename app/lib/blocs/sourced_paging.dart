import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';
import 'package:flow/cubits/flow.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/services/source.dart';

part 'sourced_paging_event.dart';
part 'sourced_paging_state.dart';

part 'sourced_paging.mapper.dart';

typedef DateFetcher<T> = Future<List<T>?> Function(
    String source, SourceService service, int offset, int limit, int date);
typedef ItemFetcher<T> = Future<List<T>?> Function(
    String source, SourceService service, int offset, int limit);
typedef SourceFetcher<T> = Future<List<T>?> Function(
    SourceService service, int offset, int limit);

class SourcedPagingBloc<T>
    extends Bloc<SourcedPagingEvent, SourcedPagingState<T>> {
  final FlowCubit cubit;
  final int pageSize;
  final bool useDates;
  final List<String>? sources;
  final DateFetcher<T> _fetch;

  SourcedPagingBloc.dated(
      {required this.cubit,
      this.sources,
      required DateFetcher<T> fetch,
      this.pageSize = 50})
      : _fetch = fetch,
        useDates = true,
        super(const SourcedPagingInitial()) {
    _init();
  }

  SourcedPagingBloc.item(
      {required this.cubit,
      this.sources,
      required ItemFetcher<T> fetch,
      this.pageSize = 50})
      : useDates = false,
        _fetch = _buildDatedFetch(fetch),
        super(const SourcedPagingInitial()) {
    _init();
  }

  SourcedPagingBloc.source({
    required this.cubit,
    required String source,
    required SourceFetcher<T> fetch,
    this.pageSize = 50,
  })  : sources = [source],
        useDates = false,
        _fetch = _buildDatedFetchSource(fetch),
        super(const SourcedPagingInitial()) {
    _init();
  }

  void _init() {
    on<SourcedPagingFetched>(_onFetched);
    on<SourcedPagingRefresh>((event, emit) {
      emit(const SourcedPagingInitial());
      fetch();
    });
    on<SourcedPagingRemoved>((event, emit) {
      final state = this.state;
      if (state is SourcedPagingSuccess<T>) {
        final items = state.dates.map((e) => e
            .where((i) =>
                i.model == event.item &&
                (event.source == null || (i.source == event.source)))
            .toList());
        emit(SourcedPagingSuccess(
          currentPageKey: state.currentPageKey,
          dates: items.toList(),
          hasReachedMax: state.hasReachedMax,
          currentDate: state.currentDate,
        ));
      }
    });
    fetch();
  }

  Future<void> _onFetched(
    SourcedPagingFetched event,
    Emitter<SourcedPagingState<T>> emit,
  ) async {
    final state = this.state;
    if (state.hasReachedMax && !useDates) return;

    final date = state.currentDate;
    final previousItems = state is SourcedPagingSuccess<T>
        ? state.dates
        : <List<SourcedModel<T>>>[];
    try {
      final currentPageKey = state.currentPageKey ??
          SourcedModel(cubit.getCurrentSources().first, 0);

      final fetchedItems = (await _fetch(
                  currentPageKey.source,
                  cubit.getService(currentPageKey.source),
                  currentPageKey.model * pageSize,
                  pageSize,
                  state.currentDate) ??
              <T>[])
          .map((e) => SourcedModel(currentPageKey.source, e))
          .toList();

      final sources = this.sources ?? cubit.getCurrentSources();
      final currentSourceIndex = sources.indexOf(currentPageKey.source);
      final keepSource = fetchedItems.length >= pageSize;
      final isLastSource = currentSourceIndex >= sources.length - 1;
      final items = List<List<SourcedModel<T>>>.from(previousItems);
      if (items.length <= date) {
        items.addAll(List.generate(
          date - items.length + 1,
          (_) => <SourcedModel<T>>[],
        ));
      }
      items[date] = [...?previousItems.elementAtOrNull(date), ...fetchedItems];

      if (isLastSource && !keepSource) {
        emit(SourcedPagingSuccess(
          currentPageKey: currentPageKey,
          dates: items,
          hasReachedMax: true,
          currentDate: useDates ? (state.currentDate + 1) : state.currentDate,
        ));
      } else if (keepSource) {
        emit(SourcedPagingSuccess(
          dates: items,
          currentPageKey: SourcedModel(
            currentPageKey.source,
            currentPageKey.model + 1,
          ),
        ));
      } else {
        final nextSource = sources[currentSourceIndex + 1];
        emit(SourcedPagingSuccess(
          dates: items,
          currentPageKey: SourcedModel(nextSource, 0),
          currentDate: date,
        ));
      }
    } catch (e) {
      emit(SourcedPagingFailure(
        e,
        currentDate: date,
        dates: previousItems,
      ));
    }
  }

  void refresh() => add(SourcedPagingRefresh());
  void fetch() {
    add(SourcedPagingFetched());
  }

  void remove(SourcedModel<T> item) =>
      add(SourcedPagingRemoved(item.model, item.source));
  void removeSourced(T item) => add(SourcedPagingRemoved(item));
}

_buildDatedFetch<T>(ItemFetcher<T> fetch) => (String source,
        SourceService service, int offset, int limit, int date) async {
      final items = await fetch(source, service, offset, limit);
      return items;
    };
_buildDatedFetchSource<T>(SourceFetcher<T> fetch) => (String source,
        SourceService service, int offset, int limit, int date) async {
      final items = await fetch(service, offset, limit);
      return items;
    };
