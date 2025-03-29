import 'package:flutter/material.dart';
import 'package:testing/models/todoModels/todo_status.dart';
import '../chooseColor/color_picker.dart';
import 'package:intl/intl.dart';  // Add this import
class TodoInput extends StatefulWidget {
  final Function(String, String, DateTime, TodoStatus, bool, Color) onSubmit;

  const TodoInput({super.key, required this.onSubmit});

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TodoStatus _status = TodoStatus.planning;
  bool _isPriority = false;
  Color _selectedColor = Colors.blue;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitTodo() {
    final title = _titleController.text.trim();
    if (title.isNotEmpty) {
      widget.onSubmit(
        title,
        _descController.text.trim(),
        _selectedDate,
        _status,
        _isPriority,
        _selectedColor,
      );
      _titleController.clear();
      _descController.clear();
      setState(() {
        _selectedDate = DateTime.now();
        _status = TodoStatus.planning;
        _isPriority = false;
        _selectedColor = Colors.blue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title*'),
          ),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 2,
          ),
          ListTile(
            title: Text(DateFormat('MMM dd, yyyy').format(_selectedDate)),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => _selectDate(context),
          ),
          DropdownButtonFormField<TodoStatus>(
            value: _status,
            items: TodoStatus.values.map((status) {
              return DropdownMenuItem<TodoStatus>(
                value: status,
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      color: status.color,
                    ),
                    const SizedBox(width: 8),
                    Text(status.text),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => setState(() => _status = value!),
          ),
          ColorPickerGrid(
            selectedColor: _selectedColor,
            onColorSelected: (color) => setState(() => _selectedColor = color),
          ),
          Row(
            children: [
              Checkbox(
                value: _isPriority,
                onChanged: (value) => setState(() => _isPriority = value ?? false),
              ),
              const Text('High Priority'),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitTodo,
                child: const Text('Add Todo'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}