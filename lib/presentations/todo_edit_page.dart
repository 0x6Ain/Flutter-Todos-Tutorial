import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/applications/todo/todo_edit_bloc/todo_edit_bloc.dart';
import 'package:flutter_todos/infra/local_storage_todos_api.dart';
import 'package:flutter_todos/models/todo.dart';

class TodoEditPage extends StatelessWidget {
  const TodoEditPage({super.key});

  static Route<void> route({Todo? initialTodo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider<TodoEditBloc>(
        create: (context) => TodoEditBloc(
          todosRepository: context.read<LocalStorageTodosApi>(),
          initialTodo: initialTodo,
        ),
        child: const TodoEditPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoEditBloc, TodoEditState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditTodoStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const TodoEditView(),
    );
  }
}

class TodoEditView extends StatelessWidget {
  const TodoEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((TodoEditBloc bloc) => bloc.state.status);
    final isNewTodo = context.select(
      (TodoEditBloc bloc) => bloc.state.isNewTodo,
    );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: isNewTodo ? const Text('add todo') : const Text('edit todo'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'this is save/edit todos',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<TodoEditBloc>().add(const EditTodoSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: const [
              _TitleField(),
              _DescriptionTitleField(),
            ]),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField();
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TodoEditBloc>().state;
    final hintText = state.initialTodo?.title ?? '';

    return TextFormField(
      key: const Key('editTodoView_title_textFormField'),
      initialValue: state.title,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Title',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<TodoEditBloc>().add(EditTodoTitleChanged(value));
      },
    );
  }
}

class _DescriptionTitleField extends StatelessWidget {
  const _DescriptionTitleField();
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TodoEditBloc>().state;
    final hintText = state.initialTodo?.description ?? '';

    return TextFormField(
      key: const Key('editTodoView_description_textFormField'),
      initialValue: state.description,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Description',
        hintText: hintText,
      ),
      maxLength: 300,
      maxLines: 7,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) {
        context.read<TodoEditBloc>().add(EditTodoDescriptionChanged(value));
      },
    );
  }
}
