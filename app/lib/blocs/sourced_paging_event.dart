part of 'sourced_paging.dart';

abstract class SourcedPagingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SourcedPagingFetched extends SourcedPagingEvent {
  SourcedPagingFetched();

  @override
  List<Object> get props => [];
}

class SourcedPagingRefresh extends SourcedPagingEvent {
  SourcedPagingRefresh();

  @override
  List<Object> get props => [];
}

class SourcedPagingRemoved extends SourcedPagingEvent {
  final String? source;
  final Object? item;

  SourcedPagingRemoved(this.item, [this.source]);

  @override
  List<Object> get props => [source, item].nonNulls.toList(growable: false);
}
