import 'package:flow/blocs/sourced_paging.dart';
import 'package:flow/widgets/paging/builder.dart';
import 'package:flow/widgets/paging/empty.dart';
import 'package:flow_api/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ItemBuilder<T> = Widget Function(
    BuildContext context, SourcedModel<T> item, int index);
typedef DateBuilder<T> = Widget Function(
    BuildContext context, List<SourcedModel<T>> date, int index);
typedef SourceBuilder<T> = Widget Function(
    BuildContext context, T item, int index);

_buildSourceItem<T>(SourceBuilder<T> itemBuilder) =>
    (BuildContext context, SourcedModel<T> item, int index) =>
        itemBuilder(context, item.model, index);

class PagedListView<T> extends StatelessWidget {
  final ItemBuilder<T>? itemBuilder;
  final DateBuilder<T>? dateBuilder;
  final SourcedPagingBloc<T>? bloc;
  final Axis? scrollDirection;

  const PagedListView.item({
    super.key,
    required this.itemBuilder,
    this.bloc,
    this.scrollDirection,
  }) : dateBuilder = null;
  const PagedListView.dated({
    super.key,
    required this.dateBuilder,
    this.bloc,
    this.scrollDirection,
  }) : itemBuilder = null;

  PagedListView.source({
    super.key,
    required SourceBuilder<T> itemBuilder,
    this.bloc,
    this.scrollDirection,
  })  : itemBuilder = _buildSourceItem(itemBuilder),
        dateBuilder = null;

  @override
  Widget build(BuildContext context) {
    return PagedBuilder(
      bloc: bloc,
      builder: (p0, state) => _PagedListView(
        state: state,
        itemBuilder: itemBuilder,
        dateBuilder: dateBuilder,
        bloc: bloc,
        scrollDirection: scrollDirection,
      ),
    );
  }
}

final class _PagedListView<T> extends StatefulWidget {
  final SourcedPagingState<T> state;
  final ItemBuilder<T>? itemBuilder;
  final DateBuilder<T>? dateBuilder;
  final SourcedPagingBloc<T>? bloc;
  final Axis? scrollDirection;

  const _PagedListView({
    super.key,
    required this.state,
    this.itemBuilder,
    this.dateBuilder,
    this.bloc,
    this.scrollDirection,
  });

  @override
  State<_PagedListView<T>> createState() => _PagedListViewState<T>();
}

class _PagedListViewState<T> extends State<_PagedListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetch();
    });
  }

  @override
  void didUpdateWidget(covariant _PagedListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != oldWidget.state) {
      setState((() => {}));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onScroll();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final useDates = widget.dateBuilder != null;
    final state = widget.state;
    final items = state.items;
    final dates = state.dates;
    if (items.isEmpty && !useDates) {
      return const EmptyIndicatorDisplay();
    }
    return ListView.builder(
      itemCount: useDates ? dates.length : items.length,
      scrollDirection: widget.scrollDirection ?? Axis.vertical,
      controller: _scrollController,
      itemBuilder: (context, index) => useDates
          ? widget.dateBuilder!(context, dates[index], index)
          : widget.itemBuilder!(context, items[index], index),
    );
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _fetch() =>
      (widget.bloc ?? context.read<SourcedPagingBloc<T>>()).fetch();

  void _onScroll() {
    if (_isBottom) {
      _fetch();
    }
  }
}
