part of 'sourced_paging.dart';

enum SourcedPagingStatus { initial, success, failure }

sealed class SourcedPagingState<T> {
  const SourcedPagingState();

  SourcedModel<int>? get currentPageKey => null;
  bool get hasReachedMax => false;
  List<List<SourcedModel<T>>> get dates => const [];
  List<SourcedModel<T>> get items => dates.expand((e) => e).toList();
  int get currentDate => 0;
}

final class SourcedPagingInitial<T> extends SourcedPagingState<T> {
  const SourcedPagingInitial();
}

@MappableClass(
    generateMethods: GenerateMethods.copy |
        GenerateMethods.stringify |
        GenerateMethods.equals)
final class SourcedPagingSuccess<T> extends SourcedPagingState<T>
    with SourcedPagingSuccessMappable<T> {
  @override
  final List<List<SourcedModel<T>>> dates;
  @override
  final SourcedModel<int> currentPageKey;
  @override
  final bool hasReachedMax;
  @override
  final int currentDate;

  const SourcedPagingSuccess({
    this.dates = const [],
    required this.currentPageKey,
    this.hasReachedMax = false,
    this.currentDate = 0,
  });
}

final class SourcedPagingFailure<T> extends SourcedPagingState<T> {
  final Object error;
  @override
  final List<List<SourcedModel<T>>> dates;
  @override
  final int currentDate;

  const SourcedPagingFailure(this.error,
      {this.dates = const [], this.currentDate = 0});

  @override
  bool get hasReachedMax => true;
}
