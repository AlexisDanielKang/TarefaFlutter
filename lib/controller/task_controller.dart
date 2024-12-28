import 'package:tarefa/api/api_service.dart';
import 'package:tarefa/model/task_model.dart';

class TaskController {
  final ApiService apiService;

  TaskController(this.apiService);

  Future<List<TaskModel>> getAllTasks() async {
    return await apiService.getTasks();
  }

  Future<void> addTask(TaskModel task) async {
    await apiService.createTask(task);
  }

  Future<void> updateTask(TaskModel task) async {
    if (task.id != null) {
      await apiService.updateTask(task.id!, task);
    }
  }

  Future<void> deleteTask(String taskId) async {
    await apiService.deleteTask(taskId);
  }
}
