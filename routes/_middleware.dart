import 'package:dart_frog/dart_frog.dart';

import '../models/in_memory_todos_data_source.dart';
import '../models/todo_data_source.dart';

final _todoDataSource = InMemoryTodosDataSource();

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<TodosDataSource>((_) => _todoDataSource));
}
