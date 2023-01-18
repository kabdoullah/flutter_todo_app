part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}
 class TodoLoadedState extends TodoState {
  final List<Todo> allTodos;
  final List<Todo> completedTodos;

  const TodoLoadedState({required this.allTodos, required this.completedTodos});

  @override
  List<Object?> get props => [allTodos, completedTodos];
 }
