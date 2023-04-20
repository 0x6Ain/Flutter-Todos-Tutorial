import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/applications/todo/todo_overview_bloc/todo_overview_bloc.dart';
import 'package:flutter_todos/infra/local_storage_todos_api.dart';
import 'package:flutter_todos/presentations/widgets/todo_list_tile.dart';

class TodosOverviewpage extends StatelessWidget {
  const TodosOverviewpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodoOverviewBloc(todoRepository: context.read<LocalStorageTodosApi>())
            ..add(
              const TodosOverviewSubscriptionRequested(),
            ),
      child: const TodosOverViews(),
    );
  }
}

class TodosOverViews extends StatelessWidget {
  const TodosOverViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter todo'),
        actions: const [],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodoOverviewBloc, TodoOverviewState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == TodosOverviewStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('to do error'),
                      ),
                    );
                }
              }),
        ],
        child: BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              if (state.status == TodosOverviewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != TodosOverviewStatus.success) {
                return const SizedBox();
              } else {
                return const Center(
                  child: Text('Is Empty'),
                );
              }
            }
            return CupertinoScrollbar(
                child: ListView(
              children: [
                for (final todo in state.filteredTodos) TodoListTile(todo: todo)
              ],
            ));
          },
        ),
      ),
    );
  }
}
