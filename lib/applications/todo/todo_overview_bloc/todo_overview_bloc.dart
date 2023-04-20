import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos/data/dummy.dart';
import 'package:flutter_todos/infra/local_storage_todos_api.dart';
import 'package:flutter_todos/models/todos_view_filter.dart';

import 'package:flutter_todos/models/todo.dart';

part 'todo_overview_event.dart';
part 'todo_overview_state.dart';

class TodoOverviewBloc extends Bloc<TodoOverviewEvents, TodoOverviewState> {
  TodoOverviewBloc({required LocalStorageTodosApi todoRepository})
      : _todoRepository = todoRepository,
        super(const TodoOverviewState()) {
    on<TodosOverviewSubscriptionRequested>(_onSubscriptionRequested);
    // on<TodosOverviewTodoCompletionToggled>(_TodoCompletionToggled);
    // on<TodosOverviewTodoDeleted>(_TodoDeleted);
    // on<TodosOverviewUndoDeletionRequested>(_UndoDeletionRequested);
    // on<TodosOverviewFilterChanged>(_FilterChanged);
    // on<TodosOverviewToggleAllRequested>(_ToggleAllRequested);
    // on<TodosOverviewClearCompletedRequested>(_ClearCompletedRequested);
  }
  final LocalStorageTodosApi _todoRepository;

  Future<void> _onSubscriptionRequested(
      TodoOverviewEvents event, Emitter<TodoOverviewState> emit) async {
    emit(state.copyWith(status: () => TodosOverviewStatus.loading));
    _todoRepository.deleteAll();
    for (final todo in dummyTodo) {
      _todoRepository.saveTodo(todo);
    }

    await emit.forEach<List<Todo>>(
      _todoRepository.getTodos(),
      onData: (todos) => state.copyWith(
        status: () => TodosOverviewStatus.success,
        todos: () => todos,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TodosOverviewStatus.failure,
      ),
    );
  }
}
