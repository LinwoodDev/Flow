import 'dart:async';

import 'package:flow/cubits/flow.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/services/source.dart';

class SourcedPagingController<T>
    extends PagingController<SourcedModel<int>, SourcedModel<T>> {
  final FlowCubit cubit;
  final int pageSize;

  List<String> get sources => cubit.getCurrentSources();

  SourcedPagingController(this.cubit, {this.pageSize = 50})
      : super(firstPageKey: const SourcedModel("", -1));

  PageRequestListener<SourcedModel<int>> addFetchListener(
      Future<List<T>?> Function(String, SourceService, int offset, int limit)
          fetch) {
    FutureOr<void> listener(SourcedModel<int> pageKey) async {
      final isFirstPage = pageKey.model < 0;
      var currentPageKey = pageKey;
      if (isFirstPage) {
        currentPageKey = SourcedModel(sources.first, 0);
      }
      final fetched = (await fetch(
                  currentPageKey.source,
                  cubit.getService(currentPageKey.source),
                  currentPageKey.model * pageSize,
                  pageSize) ??
              <T>[])
          .map((e) => SourcedModel(currentPageKey.source, e))
          .toList();
      final index = sources.indexOf(currentPageKey.source);
      final currentSource = isFirstPage ? sources.first : currentPageKey.source;
      final keepSource = fetched.length >= pageSize;
      final isLastSource = index >= sources.length - 1;
      if (isLastSource && !keepSource) {
        appendLastPage(fetched);
      } else if (keepSource) {
        appendPage(
            fetched, SourcedModel(currentSource, currentPageKey.model + 1));
      } else {
        final nextSource = sources[index + 1];
        appendPage(fetched, SourcedModel(nextSource, 0));
      }
    }

    addPageRequestListener(listener);
    return listener;
  }
}
