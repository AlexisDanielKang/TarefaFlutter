// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:tarefa/api/api_service.dart';
import 'package:tarefa/controller/task_controller.dart';

import 'package:tarefa/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    Dio dio = Dio();
    ApiService apiService = ApiService(dio);
    TaskController taskController = TaskController(apiService);

    await tester.pumpWidget( MyApp(taskController));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
