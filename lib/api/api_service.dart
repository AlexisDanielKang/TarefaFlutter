import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tarefa/model/task_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:3000/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/tasks")
  Future<List<TaskModel>> getTasks();

  @POST("/tasks")
  Future<TaskModel> createTask(@Body() TaskModel task);

  @PUT("/tasks/{id}")
  Future<TaskModel> updateTask(@Path("id") String id, @Body() TaskModel task);

  @DELETE("/tasks/{id}")
  Future<void> deleteTask(@Path("id") String id);
}
