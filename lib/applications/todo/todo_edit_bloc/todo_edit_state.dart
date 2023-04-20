part of 'todo_edit_bloc.dart';

enum EditTodoStatus { initial, loading, success, failure }

extension EditTodoStatusX on EditTodoStatus {
  bool get isLoadingOrSuccess => [
        EditTodoStatus.loading,
        EditTodoStatus.success,
      ].contains(this);
}

class TodoEditState extends Equatable {
  const TodoEditState({
    this.status = EditTodoStatus.initial,
    this.initialTodo,
    this.title = '',
    this.description = '',
  });

  final EditTodoStatus status;
  final Todo? initialTodo;
  final String title;
  final String description;

  bool get isNewTodo => initialTodo == null;

  TodoEditState copyWith({
    EditTodoStatus? status,
    Todo? initialTodo,
    String? title,
    String? description,
  }) {
    return TodoEditState(
      status: status ?? this.status,
      initialTodo: initialTodo ?? this.initialTodo,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
