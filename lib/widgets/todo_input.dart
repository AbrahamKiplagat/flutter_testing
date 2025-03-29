import 'package:flutter/material.dart';
import 'color_picker.dart';

class TodoInput extends StatefulWidget {
  final Function(String, bool, Color) onSubmit;

  const TodoInput({super.key, required this.onSubmit});

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isPriority = false;
  Color _selectedColor = Colors.blue;

  void _submitTodo() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSubmit(text, _isPriority, _selectedColor);
      _controller.clear();
      setState(() {
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
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Enter Todo'),
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
              const Text('Mark as Priority'),
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