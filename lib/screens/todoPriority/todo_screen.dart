import 'package:flutter/material.dart';
import 'package:testing/models/todoModels/todo_status.dart';
import '../../widgets/todo/todo_input.dart';
import '../../widgets/todo/todo_item.dart';  // Ensure this import path is correct
class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Map<String, dynamic>> _todos = [];

  void _addTodo(String title, String desc, DateTime date, TodoStatus status, bool priority, Color color) {
    setState(() {
      _todos.add({
        'title': title,
        'description': desc,
        'startDate': date,
        'status': status,
        'isPriority': priority,
        'color': color,
      });
    });
  }

  void _editTodo(int index, String title, String desc, DateTime date, TodoStatus status, bool priority, Color color) {
    setState(() {
      _todos[index] = {
        'title': title,
        'description': desc,
        'startDate': date,
        'status': status,
        'isPriority': priority,
        'color': color,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TodoInput(onSubmit: _addTodo),
        Expanded(
          child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) => TodoItem(
              title: _todos[index]['title'] as String,
              description: _todos[index]['description'] as String,
              startDate: _todos[index]['startDate'] as DateTime,
              status: _todos[index]['status'] as TodoStatus,
              isPriority: _todos[index]['isPriority'] as bool,
              color: _todos[index]['color'] as Color,
              onDismiss: () => setState(() => _todos.removeAt(index)),
              onEdit: (title, desc, date, status, priority, color) =>
                  _editTodo(index, title, desc, date, status, priority, color),
            ),
          ),
        ),
      ],
    );
  }
}