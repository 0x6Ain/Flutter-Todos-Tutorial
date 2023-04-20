import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    on<TodosOverviewTodoCompletionToggled>(_onTodoCompletionToggled);
    on<TodosOverviewTodoDeleted>(_onTodoDeleted);
    on<TodosOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
    on<TodosOverviewFilterChanged>(_onFilterChanged);
    on<TodosOverviewToggleAllRequested>(_onToggleAllRequested);
    on<TodosOverviewClearCompletedRequested>(_onClearCompletedRequested);
  }
  final LocalStorageTodosApi _todoRepository;

  Future<void> _onSubscriptionRequested(
      TodoOverviewEvents event, Emitter<TodoOverviewState> emit) async {
    emit(state.copyWith(status: () => TodosOverviewStatus.loading));

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

  Future<void> _onTodoCompletionToggled(
    TodosOverviewTodoCompletionToggled event,
    Emitter<TodoOverviewState> emit,
  ) async {
    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await _todoRepository.saveTodo(newTodo);
  }

  Future<void> _onTodoDeleted(
    TodosOverviewTodoDeleted event,
    Emitter<TodoOverviewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedTodo: () => event.todo));
    await _todoRepository.deleteTodo(event.todo.id);
  }

  Future<void> _onUndoDeletionRequested(
    TodosOverviewUndoDeletionRequested event,
    Emitter<TodoOverviewState> emit,
  ) async {
    assert(
      state.lastDeletedTodo != null,
      'Last deleted todo can not be null.',
    );
    final todo = state.lastDeletedTodo!;
    emit(state.copyWith(lastDeletedTodo: () => null));
    await _todoRepository.saveTodo(todo);
  }

  Future<void> _onFilterChanged(
    TodosOverviewFilterChanged event,
    Emitter<TodoOverviewState> emit,
  ) async {
    emit(state.copyWith(filter: () => event.filter));
  }

  Future<void> _onToggleAllRequested(
    TodosOverviewToggleAllRequested evnet,
    Emitter<TodoOverviewState> emit,
  ) async {
    final areAllRequested = state.todos.every((todo) => todo.isCompleted);
    await _todoRepository.completeAll(isCompleted: !areAllRequested);
  }

  Future<void> _onClearCompletedRequested(
    TodosOverviewClearCompletedRequested event,
    Emitter<TodoOverviewState> emit,
  ) async {
    await _todoRepository.clearCompleted();
  }
}
