import 'package:flutter/material.dart';

import '../blocs/bloc/todo_bloc.dart';
import '../blocs/bloc_export.dart';

class CompletedTodosScreen extends StatelessWidget {
  const CompletedTodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoadedState) {
          return Column(
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${state.completedTodos.length} Todos',
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                    itemCount: state.completedTodos.length,
                    itemBuilder: (context, index) {
                      var todo = state.completedTodos[index];
                      return ListTile(
                        title: Text(todo.title,
                            style: TextStyle(
                                decoration: todo.isDone!
                                    ? TextDecoration.lineThrough
                                    : null)),
                        subtitle: Text(todo.description),
                        trailing: Checkbox(
                          onChanged: (value) {
                            context
                                .read<TodoBloc>()
                                .add(UpdateTodoEvent(todo: todo));
                          },
                          value: todo.isDone,
                        ),
                        onLongPress: () => context
                            .read<TodoBloc>()
                            .add(DeleteTodoEvent(todo: todo)),
                      );
                    },
                  ))
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
