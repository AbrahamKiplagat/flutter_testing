import 'package:flutter/material.dart';

class TodoInput extends StatefulWidget {
  final Function(String, bool) onSubmit; // Define the 'onSubmit' parameter

  const TodoInput({super.key, required this.onSubmit}); // Mark it as required

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isPriority = false; // Checkbox state

  void _submitTodo() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSubmit(text, _isPriority); // Call the onSubmit function
      _controller.clear();
      setState(() {
        _isPriority = false; // Reset priority checkbox
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
          Row(
            children: [
              Checkbox(
                value: _isPriority,
                onChanged: (value) {
                  setState(() {
                    _isPriority = value ?? false;
                  });
                },
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
