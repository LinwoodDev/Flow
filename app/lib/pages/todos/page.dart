import 'package:flow/pages/todos/filter.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared/models/event/model.dart';
import 'package:shared/models/todo/model.dart';

import '../../cubits/flow.dart';
import 'card.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  final PagingController<int, MapEntry<Todo, String>> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
      title: AppLocalizations.of(context)!.todos,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () =>
              showSearch(context: context, delegate: _TodosSearchDelegate()),
        ),
      ],
      body: TodosBodyView(
        pagingController: _pagingController,
      ),
    );
  }
}

class _TodosSearchDelegate extends SearchDelegate {
  final PagingController<int, MapEntry<Todo, String>> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _pagingController.refresh();
    return TodosBodyView(
      pagingController: _pagingController,
      search: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class TodosBodyView extends StatefulWidget {
  final String search;
  final PagingController<int, MapEntry<Todo, String>> pagingController;

  const TodosBodyView({
    super.key,
    this.search = '',
    required this.pagingController,
  });

  @override
  State<TodosBodyView> createState() => _TodosBodyViewState();
}

class _TodosBodyViewState extends State<TodosBodyView> {
  static const _pageSize = 20;
  late final FlowCubit _flowCubit;
  final Map<int, Event> _events = {};
  TodoFilter _filter = const TodoFilter();

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    widget.pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final sources = _flowCubit.getCurrentServicesMap().entries;
      final todos = <MapEntry<Todo, String>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.todo.getTodos(
          offset: pageKey * _pageSize,
          limit: _pageSize,
          statuses: _filter.statuses,
          search: widget.search,
        );
        todos.addAll(fetched.map((todo) => MapEntry(todo, source.key)));
        if (fetched.length < _pageSize) {
          isLast = true;
        }
        for (final todo in fetched) {
          final eventId = todo.eventId;
          if (!_events.containsKey(todo.eventId) && eventId != null) {
            final event = await source.value.event.getEvent(
              eventId,
            );
            if (event != null) _events[eventId] = event;
          }
        }
      }
      if (isLast) {
        widget.pagingController.appendLastPage(todos);
      } else {
        final nextPageKey = pageKey + 1;
        widget.pagingController.appendPage(todos, nextPageKey);
      }
    } catch (error) {
      widget.pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              TodoFilterView(
                initialFilter: _filter,
                onChanged: (filter) {
                  setState(() {
                    _filter = filter;
                    widget.pagingController.refresh();
                  });
                },
              ),
              const SizedBox(height: 8),
              Flexible(
                child: PagedListView(
                  pagingController: widget.pagingController,
                  builderDelegate:
                      PagedChildBuilderDelegate<MapEntry<Todo, String>>(
                          itemBuilder: (context, item, index) => TodoCard(
                                event: _events[item.key.eventId],
                                todo: item.key,
                                source: item.value,
                                controller: widget.pagingController,
                              )),
                ),
              ),
            ],
          )),
    );
  }
}
