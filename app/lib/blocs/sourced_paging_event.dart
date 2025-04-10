part of 'sourced_paging.dart';

abstract class SourcedPagingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SourcedPagingFetched<T> extends SourcedPagingEvent {
  SourcedPagingFetched();

  @override
  List<Object> get props => [];
}

class SourcedPagingRefresh<T> extends SourcedPagingEvent {
  SourcedPagingRefresh();

  @override
  List<Object> get props => [];
}
