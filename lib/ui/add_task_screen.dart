import 'package:flutter/material.dart';
import 'package:tarefa/model/task_model.dart';
import 'package:tarefa/controller/task_controller.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskController taskController;
  final TaskModel? task;

  AddTaskScreen(this.taskController, {this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _describeController = TextEditingController();
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _describeController.text = widget.task!.describe ?? '';
      _isCompleted = widget.task!.isCompleted;
    }
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {

      final task  = TaskModel(
        id: widget.task?.id,
        title: _titleController.text,
        describe: _describeController.text,
        isCompleted: _isCompleted,
      );

      if (widget.task == null) {
        await widget.taskController.addTask(task);
      } else {
        await widget.taskController.updateTask(task);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? "Nova Tarefa" : "Editar Tarefa")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Título"),
                key: Key("title"),
                validator: (value) =>
                value!.isEmpty ? "Insira um título" : null,
              ),
              TextFormField(
                controller: _describeController,
                decoration: InputDecoration(labelText: "Descrição"),
                key: Key("describe"),
              ),
              SwitchListTile(
                title: Text("Concluída?"),
                key: Key("isCompleted"),
                value: _isCompleted,
                onChanged: (value) => setState(() => _isCompleted = value),
              ),
              ElevatedButton(
                onPressed: _saveTask,
                child: Text(widget.task == null ? "Salvar" : "Atualizar"),
                key: Key("saveOrUpdate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
