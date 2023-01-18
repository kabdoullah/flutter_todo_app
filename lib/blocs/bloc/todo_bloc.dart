import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../models/todo.dart';
import '../../services/todo.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService todoService;

  TodoBloc({required this.todoService}) : super(TodoInitial()) {
    on<LoadTodoEvent>((event, emit) async {
      final allTodos = await todoService.getTodos();
      final completedTodos = await todoService.getCompletedTodos();
      emit(TodoLoadedState(allTodos: allTodos, completedTodos: completedTodos));
    });
    on<AddTodoEvent>(_onAddTodoEvent);
    on<UpdateTodoEvent>(_onUpdateTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
  }

  void _onAddTodoEvent(AddTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state as TodoLoadedState;
    List<Todo> allTodos = List.from(state.allTodos)
      ..add(event.todo);
    todoService.addTodo(event.todo);
    emit(TodoLoadedState(
        allTodos: allTodos, completedTodos: state.completedTodos));
  }

  void _onUpdateTodoEvent(UpdateTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state as TodoLoadedState;
    final todo = event.todo;
    //final int index = state.allTodos.indexOf(todo);
    List<Todo> allTodos = state.allTodos;
    List<Todo> completedTodos = state.completedTodos;
    todo.isDone == false
        ? {
      allTodos = List.from(allTodos)
        ..remove(todo),
      todoService.removeTodo(todo),
      completedTodos = List.from(completedTodos)
        ..insert(0, todo.copyWith(isDone: true)),
      todoService.updateTodo(todo),
      todoService.addCompletedTodo(todo)
    }
        : {
      completedTodos = List.from(completedTodos)
        ..remove(todo)
    ,
    todoService.removeTodo(todo),
    allTodos = List.from(allTodos)
    ..insert(0, todo.copyWith(isDone: false)),
    todoService.updateTodo(todo),
    todoService.addCompletedTodo(todo)
    };

    emit(TodoLoadedState(
    allTodos: allTodos, completedTodos: completedTodos));
    }

  void _onDeleteTodoEvent(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state as TodoLoadedState;
    final todo = event.todo;
    List<Todo> allTodos = List.from(state.allTodos)
      ..remove(todo);
    todoService.removeTodo(todo);
    emit(TodoLoadedState(
        allTodos: allTodos, completedTodos: state.completedTodos));
  }
}
