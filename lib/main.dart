import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tarefa/api/api_service.dart';
import 'package:tarefa/ui/task_list_sreen.dart';

import 'controller/task_controller.dart';

void main() {
  Dio dio = Dio();

  ApiService apiService = ApiService(dio);

  TaskController taskController = TaskController(apiService);

  runApp(MyApp(taskController));
}

class MyApp extends StatelessWidget {
  final TaskController taskController;

  MyApp(this.taskController);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(taskController, taskApiService: null,),
    );
  }
}
