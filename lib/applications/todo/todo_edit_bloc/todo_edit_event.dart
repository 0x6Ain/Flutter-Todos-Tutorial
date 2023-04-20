part of 'todo_edit_bloc.dart';

abstract class TodoEditEvent extends Equatable {
  const TodoEditEvent();

  @override
  List<Object> get props => [];
}

class EditTodoTitleChanged extends TodoEditEvent {
  const EditTodoTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class EditTodoDescriptionChanged extends TodoEditEvent {
  const EditTodoDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class EditTodoSubmitted extends TodoEditEvent {
  const EditTodoSubmitted();
}
