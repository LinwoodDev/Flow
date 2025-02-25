import 'dart:async';

import 'package:flow/cubits/flow.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flow_api/models/model.dart';
import 'package:flow_api/services/source.dart';

const kDefaultPageSize = 50;

typedef SourcedPagingController<T>
    = PagingController<SourcedModel<int>, SourcedModel<T>>;

SourcedPagingController<T> createSourcedPagingController<T>({
  required FlowCubit cubit,
  int pageSize = kDefaultPageSize,
  required Future<List<T>?> Function(
          String, SourceService, int offset, int limit)
      fetch,
}) {
  final sources = cubit.getCurrentSources();
  return SourcedPagingController(
    fetchPage: (pageKey) async {
      final fetched = (await fetch(
                  pageKey.source,
                  cubit.getService(pageKey.source),
                  pageKey.model * pageSize,
                  pageSize) ??
              <T>[])
          .map((e) => SourcedModel(pageKey.source, e))
          .toList();
      return fetched;
    },
    getNextPageKey: (state) {
      final keys = state.keys?.lastOrNull;
      if (keys == null) {
        return SourcedModel(sources.first, 0);
      }
      final items = state.pages?.lastOrNull;
      final isFinished = items == null || items.length < pageSize;
      if (!isFinished) {
        return SourcedModel(keys.source, keys.model + 1);
      }
      final index = sources.indexOf(keys.source);
      if (index >= sources.length - 1 || index < 0) {
        return null;
      }
      return SourcedModel(sources[index + 1], 0);
    },
  );
}
