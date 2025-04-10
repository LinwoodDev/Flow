import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/widgets/paging/error.dart';
import 'package:flow/widgets/paging/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class PagedBuilder<T> extends StatelessWidget {
  final Widget Function(BuildContext, SourcedPagingSuccess<T> state) builder;
  final SourcedPagingBloc<T>? bloc;

  const PagedBuilder({super.key, required this.builder, this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourcedPagingBloc<T>, SourcedPagingState<T>>(
      bloc: bloc,
      builder: (context, state) => switch (state) {
        SourcedPagingInitial<T>() => LoadingIndicatorDisplay(),
        SourcedPagingFailure<T>() => ErrorIndicatorDisplay(
            onTryAgain: () => (bloc ?? context.read<SourcedPagingBloc<T>>())
                .add(SourcedPagingRefresh()),
          ),
        SourcedPagingSuccess<T>() => builder(context, state),
      },
    );
  }
}
