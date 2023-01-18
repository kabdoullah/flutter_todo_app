import 'package:flutter_todo/models/todo.dart';
import 'package:hive/hive.dart';

class TodoService {
  late Box<Todo> _todos;
  late Box<Todo> _completedTodos;

// allTodo Service
  Future<List<Todo>> getTodos() async {
    Hive.registerAdapter(TodoAdapter());
    _todos = await Hive.openBox<Todo>('todos');
    //_todos.clear();
    final tasks = _todos.values;
    return tasks.toList();
  }

  void addTodo(final Todo todo) {
    _todos.add(todo);
  }

  Future<void> removeTodo(final Todo todo) async {
    final todoToRemove = _todos.values.firstWhere((element) => element == todo);
    await todoToRemove.delete();
  }

  Future<void> updateTodo(final Todo todo) async {
    final todoToEdit = _todos.values.firstWhere((element) => element == todo);
    print("todoToEdit   : ${todoToEdit.title}");
    final index = todoToEdit.key as int;
    print("index   : $index");
    await _todos.put(index, Todo(id: todoToEdit.id, title: todoToEdit.title, description: todoToEdit.description, isDone: !todoToEdit.isDone!));
  }

// Completed Todo

  Future<List<Todo>> getCompletedTodos() async {
    _completedTodos = await Hive.openBox<Todo>("completedTodo");
    final completedTasks = _completedTodos.values;
    return completedTasks.toList();
  }

  void addCompletedTodo(final Todo todo) {
    _completedTodos.add(todo);
  }

  Future<void> removeCompletedTodo(final Todo todo) async {
    final todoToRemove = _completedTodos.values.firstWhere((element) => element == todo);
    await todoToRemove.delete();
  }

  Future<void> updateCompletedTodo(final Todo todo) async {
    final todoToEdit = _completedTodos.values.firstWhere((element) => element == todo);
    final index = todoToEdit.key as int;
    await _completedTodos.put(index, Todo(id: todoToEdit.id, title: todoToEdit.title, description: todoToEdit.description, isDone: !todoToEdit.isDone!));
  }

}




