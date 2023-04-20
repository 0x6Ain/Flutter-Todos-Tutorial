import 'package:flutter_todos/models/todo.dart';

enum TodosViewFilter { all, activeOnly, completedOnly }

extension TodoViewFilter on TodosViewFilter {
  bool apply(Todo todo) {
    switch (this) {
      case TodosViewFilter.all:
        return true;
      case TodosViewFilter.activeOnly:
        return !todo.isCompleted;
      case TodosViewFilter.completedOnly:
        return !todo.isCompleted;
    }
  }

  Iterable<Todo> applyAll(Iterable<Todo> todos) {
    return todos.where(apply);
  }
}
