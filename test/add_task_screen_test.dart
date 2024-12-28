import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:tarefa/controller/task_controller.dart';
import 'package:tarefa/ui/add_task_screen.dart';
import 'package:tarefa/model/task_model.dart';
import 'add_task_screen_test.mocks.dart';

@GenerateMocks([TaskController])
void main() {
  late MockTaskController mockTaskController;

  setUp(() {
    mockTaskController = MockTaskController();
  });


  testWidgets('Deve adicionar uma nova tarefa com valores personalizados', (WidgetTester tester) async {

    const taskTitle = 'Fazer teste';
    const taskDescription = 'Realizar teste para aoprovação do trabalho';
    const isTaskCompleted = true;

    await tester.pumpWidget(MaterialApp(
      home: AddTaskScreen(mockTaskController),
    ));

    await tester.enterText(
        find.byKey(Key('title')), taskTitle);
    await tester.enterText(
        find.byKey(Key('describe')), taskDescription);
    await tester.tap(find.byKey(Key('isCompleted')));
    await tester.pump();

    // Simula o clique no botão Salvar
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    // Verifica se o método addTask foi chamado com os valores corretos
    verify(mockTaskController.addTask(TaskModel(
      title: taskTitle,
      describe: taskDescription,
      isCompleted: isTaskCompleted,
    ))).called(1);
  });
}
