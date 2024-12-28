import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarefa/ui/add_task_screen.dart';
import 'package:tarefa/controller/task_controller.dart';
import 'package:tarefa/model/task_model.dart';

class TaskListScreen extends StatefulWidget {
  final TaskController taskController;

  TaskListScreen(this.taskController, {required taskApiService});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  static const platform = MethodChannel('com.example.tarefa/dateTime');
  String _currentTime = "Carregando...";
  List<TaskModel> tasks = [];
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    _loadTasks();
    if (Platform.isAndroid || Platform.isIOS) {
      _startFetchingTime();
    }
  }

  Future<void> _startFetchingTime() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      try {
        final String result = await platform.invokeMethod('getCurrentTime');
        setState(() {
          _currentTime = result;
        });
      } on PlatformException catch (e) {
        setState(() {
          _currentTime = "Erro ao obter hora: ${e.message}";
        });
      }
    });
  }

  Future<void> _loadTasks() async {
    setState(() => isLoading = true);
    tasks = await widget.taskController.getAllTasks();
    setState(() => isLoading = false);
  }

  Future<void> _deleteTask(String id) async {
    await widget.taskController.deleteTask(id);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Tarefas"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _currentTime,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.describe ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddTaskScreen(widget.taskController, task: task),
                      ),
                    );
                    if (result == true) _loadTasks();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTask(task.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: Key('add'),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(widget.taskController),
            ),
          );
          if (result == true) _loadTasks();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
