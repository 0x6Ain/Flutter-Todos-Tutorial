import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos/infra/local_storage_todos_api.dart';
import 'package:flutter_todos/models/todo.dart';

part 'todo_edit_event.dart';
part 'todo_edit_state.dart';

class TodoEditBloc extends Bloc<TodoEditEvent, TodoEditState> {
  TodoEditBloc({
    required LocalStorageTodosApi todosRepository,
    required Todo? initialTodo,
  })  : _todosRepository = todosRepository,
        super(
          TodoEditState(
            initialTodo: initialTodo,
            title: initialTodo?.title ?? '',
            description: initialTodo?.description ?? '',
          ),
        ) {
    on<EditTodoTitleChanged>(_onEditTodoTitleChanged);
    on<EditTodoDescriptionChanged>(_onEditTodoDescriptionChanged);
    on<EditTodoSubmitted>(_onEditTodoSubmitted);
  }

  final LocalStorageTodosApi _todosRepository;

  void _onEditTodoTitleChanged(
    EditTodoTitleChanged event,
    Emitter<TodoEditState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onEditTodoDescriptionChanged(
    EditTodoDescriptionChanged event,
    Emitter<TodoEditState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onEditTodoSubmitted(
    EditTodoSubmitted event,
    Emitter<TodoEditState> emit,
  ) async {
    emit(state.copyWith(status: EditTodoStatus.loading));

    final todo = (state.initialTodo ?? Todo(title: '')).copyWith(
      title: state.title,
      description: state.description,
    );
    try {
      await _todosRepository.saveTodo(todo);
      emit(state.copyWith(status: EditTodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditTodoStatus.failure));
    }
  }
}
