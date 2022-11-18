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
  static const _pageSize = 10;
  late final FlowCubit _flowCubit;
  final PagingController<int, MapEntry<Todo, String>> _pagingController =
      PagingController(firstPageKey: 0);
  final Map<int, Event> _events = {};
  TodoFilter _filter = const TodoFilter();

  @override
  void initState() {
    _flowCubit = context.read<FlowCubit>();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
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
          incomplete: _filter.showIncompleted,
          completed: _filter.showCompleted,
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
        _pagingController.appendLastPage(todos);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(todos, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlowNavigation(
        title: AppLocalizations.of(context)!.todos,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              final filter = await showDialog<TodoFilter>(
                context: context,
                builder: (context) => TodoFilterDialog(
                  initialFilter: _filter,
                ),
              );
              if (filter != null) {
                setState(() {
                  _filter = filter;
                  _pagingController.refresh();
                });
              }
            },
          ),
        ],
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: PagedListView(
                pagingController: _pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<MapEntry<Todo, String>>(
                        itemBuilder: (context, item, index) => TodoCard(
                              event: _events[item.key.eventId],
                              todo: item.key,
                              source: item.value,
                              controller: _pagingController,
                            )),
              )),
        ));
  }
}
