import 'package:flutter/material.dart';
import '../widgets/todo_input.dart';
import '../widgets/todo_item.dart';  // Ensure this import path is correct

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Map<String, dynamic>> _todos = [];

  void _addTodo(String text, bool isPriority, Color color) {
    setState(() {
      _todos.add({
        'title': text, 
        'isPriority': isPriority,
        'color': color,
      });
    });
  }

  void _editTodo(int index, String newText, bool isPriority, Color newColor) {
    setState(() {
      _todos[index] = {
        'title': newText,
        'isPriority': isPriority,
        'color': newColor,
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
              title: _todos[index]['title'],
              isPriority: _todos[index]['isPriority'],
              color: _todos[index]['color'],
              onDismiss: () => setState(() => _todos.removeAt(index)),
              onEdit: (newText, isPriority, newColor) => 
                  _editTodo(index, newText, isPriority, newColor),
            ),
          ),
        ),
      ],
    );
  }
}