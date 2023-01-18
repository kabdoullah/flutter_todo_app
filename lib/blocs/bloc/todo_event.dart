part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class LoadTodoEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  const AddTodoEvent({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;

  const UpdateTodoEvent({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  const DeleteTodoEvent({required this.todo});
  @override
  List<Object?> get props => [todo];
}
