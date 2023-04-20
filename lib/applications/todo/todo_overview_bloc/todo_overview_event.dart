part of 'todo_overview_bloc.dart';

abstract class TodoOverviewEvents extends Equatable {
  const TodoOverviewEvents();
  @override
  List<Object?> get props => [];
}

class TodosOverviewSubscriptionRequested extends TodoOverviewEvents {
  const TodosOverviewSubscriptionRequested();
}

// class TodosOverviewTodoCompletionToggled extends TodoOverviewEvents {
//   const TodosOverviewTodoCompletionToggled({
//     required this.todo,
//     required this.isCompleted,
//   });

//   final Todo todo;
//   final bool isCompleted;

//   @override
//   List<Object?> get props => [
//         todo,
//         isCompleted,
//       ];
// }

// class TodosOverviewTodoDeleted extends TodoOverviewEvents {
//   const TodosOverviewTodoDeleted(this.todo);

//   final Todo todo;

//   @override
//   List<Object?> get props => [
//         todo,
//       ];
// }

// class TodosOverviewUndoDeletionRequested extends TodoOverviewEvents {
//   const TodosOverviewUndoDeletionRequested();
// }

// class TodosOverviewFilterChanged extends TodoOverviewEvents {
//   const TodosOverviewFilterChanged(this.filter);

//   final TodosViewFilter filter;

//   @override
//   List<Object> get props => [filter];
// }

// class TodosOverviewToggleAllRequested extends TodoOverviewEvents {
//   const TodosOverviewToggleAllRequested();
// }

// class TodosOverviewClearCompletedRequested extends TodoOverviewEvents {
//   const TodosOverviewClearCompletedRequested();
// }
