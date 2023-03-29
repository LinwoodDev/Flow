import 'dart:async';

import 'package:flow/cubits/flow.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/model.dart';
import 'package:shared/services/source.dart';

class SourcedPagingController<T>
    extends PagingController<SourcedModel<int>, SourcedModel<T>> {
  final FlowCubit cubit;
  final int pageSize;

  List<String> get sources => cubit.getCurrentSources();

  SourcedPagingController(this.cubit, {this.pageSize = 50})
      : super(firstPageKey: const SourcedModel("", -1));

  PageRequestListener<SourcedModel<int>> addFetchListener(
      Future<List<T>?> Function(String, SourceService, int, int) fetch) {
    FutureOr<void> listener(SourcedModel<int> pageKey) async {
      final fetched = (await fetch(
                  pageKey.source,
                  cubit.getSource(pageKey.source),
                  pageKey.model * pageSize,
                  pageSize) ??
              <T>[])
          .map((e) => SourcedModel(pageKey.source, e))
          .toList();
      final index = sources.indexOf(pageKey.source);
      final isFirstPage = pageKey.model < 0;
      final currentSource = isFirstPage ? sources.first : pageKey.source;
      final keepSource = fetched.length >= pageSize;
      final isLastSource = index >= sources.length - 1;
      if (isLastSource && !keepSource) {
        appendLastPage(fetched);
      } else if (keepSource) {
        appendPage(fetched, SourcedModel(currentSource, pageKey.model + 1));
      } else {
        final nextSource = sources[index + 1];
        appendPage(fetched, SourcedModel(nextSource, 0));
      }
    }

    addPageRequestListener(listener);
    return listener;
  }
}
