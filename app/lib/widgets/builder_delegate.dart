import 'package:flow/widgets/indicators/empty.dart';
import 'package:flow/widgets/indicators/error.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'indicators/loading.dart';

PagedChildBuilderDelegate<T> buildMaterialPagedDelegate<T>(
        PagingController<dynamic, T> controller,
        ItemWidgetBuilder<T> itemBuilder) =>
    PagedChildBuilderDelegate<T>(
      itemBuilder: itemBuilder,
      firstPageProgressIndicatorBuilder: (context) =>
          const LoadingIndicatorDisplay(),
      firstPageErrorIndicatorBuilder: (context) =>
          ErrorIndicatorDisplay(onTryAgain: controller.refresh),
      animateTransitions: true,
      newPageErrorIndicatorBuilder: (context) => ErrorIndicatorDisplay(
        onTryAgain: controller.retryLastFailedRequest,
      ),
      newPageProgressIndicatorBuilder: (context) =>
          const LoadingIndicatorDisplay(),
      noItemsFoundIndicatorBuilder: (context) => const EmptyIndicatorDisplay(),
    );
