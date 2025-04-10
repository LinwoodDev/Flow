import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/widgets/paging/empty.dart';
import 'package:flow/widgets/paging/error.dart';
import 'package:flow/widgets/paging/loading.dart';
import 'package:flow_api/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class PagedListView<T> extends StatelessWidget {
  final Widget Function(BuildContext context, SourcedModel<T> item, int index)
      itemBuilder;

  const PagedListView({super.key, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourcedPagingBloc<T>, SourcedPagingState<T>>(
      builder: (context, state) {
        return switch (state) {
          SourcedPagingInitial<T>() => LoadingIndicatorDisplay(),
          SourcedPagingFailure<T>() => ErrorIndicatorDisplay(
              onTryAgain: () => context
                  .read<SourcedPagingBloc<T>>()
                  .add(SourcedPagingRefresh()),
            ),
          SourcedPagingSuccess<T>() => _buildSuccess(state),
        };
      },
    );
  }

  Widget _buildSuccess(SourcedPagingSuccess<T> state) {
    if (state.items.isEmpty) {
      return const EmptyIndicatorDisplay();
    }
    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (context, index) =>
          itemBuilder(context, state.items[index], index),
    );
  }
}
