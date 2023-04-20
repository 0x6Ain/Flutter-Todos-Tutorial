part of 'todo_overview_bloc.dart';

enum TodosOverviewStatus { initial, loading, success, failure }

class TodoOverviewState extends Equatable {
  const TodoOverviewState(
      {this.status = TodosOverviewStatus.initial,
      this.todos = const [],
      this.filter = TodosViewFilter.all,
      this.lastDeletedTodo});

  final TodosOverviewStatus status;
  final List<Todo> todos;
  final TodosViewFilter filter;
  final Todo? lastDeletedTodo;

  Iterable<Todo> get filteredTodos => filter.applyAll(todos);

  TodoOverviewState copyWith({
    TodosOverviewStatus Function()? status,
    List<Todo> Function()? todos,
    TodosViewFilter Function()? filter,
    Todo? Function()? lastDeletedTodo,
  }) {
    return TodoOverviewState(
      status: status != null ? status() : this.status,
      todos: todos != null ? todos() : this.todos,
      filter: filter != null ? filter() : this.filter,
      lastDeletedTodo:
          lastDeletedTodo != null ? lastDeletedTodo() : this.lastDeletedTodo,
    );
  }

  @override
  List<Object?> get props => [
        status,
        todos,
        filter,
        lastDeletedTodo,
      ];
}
