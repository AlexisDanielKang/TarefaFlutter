import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarefa/ui/task_list_sreen.dart';
import 'package:tarefa/controller/task_controller.dart';
import 'package:tarefa/model/task_model.dart';
import 'package:mockito/mockito.dart';
import 'package:tarefa/api/api_service.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  testWidgets('Abrir o AddTaskScreen ao clicar no botão de adicionar tarefa', (WidgetTester tester) async {
    final mockApiService = MockApiService();

    when(mockApiService.getTasks()).thenAnswer(
          (_) async => [TaskModel(id: '1', title: 'Task 1', describe: 'Descrição da tarefa', isCompleted: true)],
    );

    TaskController taskController = TaskController(mockApiService);

    await tester.pumpWidget(
      MaterialApp(
        home: TaskListScreen(taskController, taskApiService: mockApiService,),
      ),
    );

    final addButton = find.byKey(Key('add'));

    expect(addButton, findsOneWidget);

    await tester.tap(addButton);

    await tester.pumpAndSettle();

    expect(find.text('Adicionar Tarefa'), findsOneWidget);
  });
}
