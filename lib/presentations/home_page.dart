import 'package:flutter/material.dart';
import 'package:flutter_todos/presentations/todo_edit_page.dart';
import 'package:flutter_todos/presentations/todos_overview_Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: 0,
        children: const [TodosOverviewpage()],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('homeView_addTodo_floatingActionButton'),
        onPressed: () => Navigator.of(context).push(TodoEditPage.route()),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: const Icon(Icons.add),
      ),
    );
  }
}
