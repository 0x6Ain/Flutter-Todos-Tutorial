import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/applications/todo/todo_overview_bloc/todo_overview_bloc.dart';
import 'package:flutter_todos/models/todos_view_filter.dart';

class TodosOverviewFilterButton extends StatelessWidget {
  const TodosOverviewFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final activeFilter =
        context.select((TodoOverviewBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TodosViewFilter>(
      initialValue: activeFilter,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      onSelected: (filter) {
        context
            .read<TodoOverviewBloc>()
            .add(TodosOverviewFilterChanged(filter));
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: TodosViewFilter.all,
            child: Text('all'),
          ),
          PopupMenuItem(
            value: TodosViewFilter.activeOnly,
            child: Text('activeOnly'),
          ),
          PopupMenuItem(
            value: TodosViewFilter.completedOnly,
            child: Text('CompletedOnly'),
          ),
        ];
      },
    );
  }
}
