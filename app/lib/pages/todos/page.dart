import 'package:flow/helpers/event.dart';
import 'package:flow/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:shared/models/event/model.dart';

import '../../cubits/flow.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  static const _pageSize = 10;
  late final FlowCubit _flowCubit;
  final PagingController<int, MapEntry<EventTodo, String>> _pagingController =
      PagingController(firstPageKey: 0);
  final Map<int, Event> _events = {};

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
      final todos = <MapEntry<EventTodo, String>>[];
      var isLast = false;
      for (final source in sources) {
        final fetched = await source.value.eventTodo.getTodos(
          offset: pageKey * _pageSize,
          limit: _pageSize,
        );
        todos.addAll(fetched.map((todo) => MapEntry(todo, source.key)));
        if (fetched.length < _pageSize) {
          isLast = true;
        }
        for (final todo in fetched) {
          if (!_events.containsKey(todo.eventId)) {
            final event = await source.value.event.getEvent(
              todo.eventId,
            );
            if (event != null) _events[todo.eventId] = event;
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
        selected: "todos",
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: PagedListView(
                pagingController: _pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<MapEntry<EventTodo, String>>(
                        itemBuilder: (context, item, index) => _TodoCard(
                              event: _events[item.key.eventId],
                              todo: item.key,
                              source: item.value,
                            )),
              )),
        ));
  }
}

class _TodoCard extends StatelessWidget {
  final String source;
  final Event? event;
  final EventTodo todo;

  const _TodoCard({
    required this.source,
    required this.event,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final dateFormatter = DateFormat.yMMMMd(locale);
    final timeFormatter = DateFormat.Hm(locale);
    final _todoService =
        context.read<FlowCubit>().getCurrentServicesMap()[source]?.eventTodo;
    var newTodo = todo;
    void _updateTodo() {
      _todoService?.updateTodo(
        newTodo,
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StatefulBuilder(builder: (context, setState) {
                  return Checkbox(
                    value: newTodo.done,
                    onChanged: (value) {
                      setState(() {
                        newTodo = newTodo.copyWith(done: value!);
                        _updateTodo();
                      });
                    },
                  );
                }),
                const SizedBox(width: 8),
                Flexible(
                    child: TextFormField(
                        initialValue: todo.name,
                        style: Theme.of(context).textTheme.headline6)),
              ],
            ),
            if (source.isNotEmpty)
              Text(source, style: Theme.of(context).textTheme.caption),
            if (event != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(event!.status.getIcon(),
                        color: event!.status.getColor()),
                    const SizedBox(width: 8),
                    Text(
                        AppLocalizations.of(context)!.eventInfo(
                          event!.name,
                          event?.start == null
                              ? '-'
                              : dateFormatter.format(event!.start!),
                          event?.start == null
                              ? '-'
                              : timeFormatter.format(event!.start!),
                          event!.location.isEmpty ? '-' : event!.location,
                          event!.status.getLocalizedName(context),
                        ),
                        style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: todo.description,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
                border: const OutlineInputBorder(),
              ),
              minLines: 3,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
