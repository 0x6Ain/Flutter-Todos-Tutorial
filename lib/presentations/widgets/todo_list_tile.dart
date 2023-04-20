import 'package:flutter/material.dart';

import 'package:flutter_todos/models/todo.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    super.key,
    required this.todo,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
  });
  final Todo todo;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('todo ListTile dismissabele ${todo.title}'),
      child: ListTile(
        onTap: onTap,
        title: Text(todo.title),
        subtitle: Text(todo.description),
      ),
    );
  }
}
