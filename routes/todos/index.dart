import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../models/todo_data_source.dart';
import '../../models/todo_model.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);
    case HttpMethod.post:
      return _post(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context) async {
  final todosDataSource = context.read<TodosDataSource>();
  final todos = await todosDataSource.readAll();
  return Response.json(body: todos);
}

Future<Response> _post(RequestContext context) async {
  final todosDataSource = context.read<TodosDataSource>();
  final todo = Todo.fromJson(
    await context.request.json() as Map<String, dynamic>,
  );
  return Response.json(
    statusCode: HttpStatus.created,
    body: await todosDataSource.create(todo),
  );
}
