import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/infra/local_storage_todos_api.dart';
import 'package:flutter_todos/presentations/home_page.dart';
import 'package:flutter_todos/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key, required this.todoRepository});

  final LocalStorageTodosApi todoRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: todoRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterTodosTheme.light,
      darkTheme: FlutterTodosTheme.dark,
      //   localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
