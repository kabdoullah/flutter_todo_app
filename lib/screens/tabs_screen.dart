import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/todo_screen.dart';

import 'add_todo_screen.dart';
import 'completed_todo_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
          child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddTaskScreen(),
      )),
    );
  }

  final List<Map<String, dynamic>> _pages = [
    {"pageName": const TodoScreen(), "title": "Todo List"},
    {"pageName": const CompletedTodosScreen(), "title": "Completed Todo"},
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[currentIndex]['title']),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _addTask(context), icon: const Icon(Icons.add))
        ],
      ),
      body: _pages[currentIndex]['pageName'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Todo List"),
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_outlined), label: "Completed"),
        ],
      ),
      floatingActionButton: currentIndex == 0 ? FloatingActionButton(
        onPressed: () => _addTask(context),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}
