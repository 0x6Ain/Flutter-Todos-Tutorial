import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todos/app/app.dart';
import 'package:flutter_todos/app/app_bloc_observer.dart';
import 'package:flutter_todos/infra/local_storage_todos_api.dart';

void bootstrap({required LocalStorageTodosApi todosApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  runZonedGuarded(
    () => runApp(App(todoRepository: todosApi)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
