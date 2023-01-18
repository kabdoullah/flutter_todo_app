import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/tabs_screen.dart';
import 'package:flutter_todo/screens/todo_screen.dart';
import 'package:flutter_todo/services/todo.dart';
import 'package:hive_flutter/adapters.dart';

import 'blocs/bloc/todo_bloc.dart';
import 'blocs/bloc_export.dart';
import 'models/todo.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoService(),
      child: BlocProvider(
        create: (context) => TodoBloc(todoService: TodoService())..add(LoadTodoEvent()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const TabsScreen(),
        ),
      ),
    );
  }
}
