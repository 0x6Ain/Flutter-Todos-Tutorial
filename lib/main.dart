import 'package:flutter/material.dart';
import 'package:flutter_todos/bootstrap.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'infra/local_storage_todos_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todosApi = LocalStorageTodosApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(todosApi: todosApi);
}
