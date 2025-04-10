part of 'sourced_paging.dart';

enum SourcedPagingStatus { initial, success, failure }

sealed class SourcedPagingState<T> {
  const SourcedPagingState();

  SourcedModel<int>? get currentPageKey => null;
  bool get hasReachedMax => false;
  List<SourcedModel<T>> get items => const [];
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
  final List<SourcedModel<T>> items;
  @override
  final SourcedModel<int> currentPageKey;
  @override
  final bool hasReachedMax;

  const SourcedPagingSuccess({
    this.items = const [],
    required this.currentPageKey,
    this.hasReachedMax = false,
  });
}

final class SourcedPagingFailure<T> extends SourcedPagingState<T> {
  final Object error;
  @override
  final List<SourcedModel<T>> items;

  const SourcedPagingFailure(this.error, {this.items = const []});

  @override
  bool get hasReachedMax => true;
}
