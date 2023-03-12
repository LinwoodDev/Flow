import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/models/todo/model.dart';

import '../../cubits/flow.dart';

class DashboardTodosCard extends StatelessWidget {
  const DashboardTodosCard({Key? key}) : super(key: key);

  Future<List<Todo>> _getTodos(BuildContext context) async {
    final sources = context.read<FlowCubit>().getCurrentServices();
    final todos = <Todo>[];
    for (final source in sources) {
      todos.addAll(await source.todo?.getTodos() ?? []);
    }
    return todos;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context).todos,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.open_in_new_outlined),
              onPressed: () => GoRouter.of(context).go('/todos'),
            )
          ],
        ),
        const SizedBox(height: 20),
        FutureBuilder<List<Todo>>(
            future: _getTodos(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              final todos = snapshot.data!;
              return Column(
                children: todos
                    .map((e) => ListTile(
                          title: Text(e.name),
                          subtitle: Text(e.description),
                        ))
                    .toList(),
              );
            })
      ],
    );
  }
}
