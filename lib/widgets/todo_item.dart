// todo_item.dart
import 'package:flutter/material.dart';
import 'package:testing/widgets/color_picker.dart';

class TodoItem extends StatefulWidget {
  final String title;
  final bool isPriority;
  final Color color;
  final VoidCallback onDismiss;
  final Function(String, bool, Color) onEdit;

  const TodoItem({
    super.key,
    required this.title,
    required this.isPriority,
    required this.color,
    required this.onDismiss,
    required this.onEdit,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late TextEditingController _editController;
  late bool _currentPriority;
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.title);
    _currentPriority = widget.isPriority;
    _currentColor = widget.color;
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _editController,
              decoration: const InputDecoration(labelText: 'Todo Title'),
            ),
            CheckboxListTile(
              title: const Text('High Priority'),
              value: _currentPriority,
              onChanged: (value) => setState(() => _currentPriority = value!),
            ),
            ColorPickerGrid(
              selectedColor: _currentColor,
              onColorSelected: (color) => setState(() => _currentColor = color),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onEdit(
                _editController.text,
                _currentPriority,
                _currentColor,
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: widget.color,
      title: Text(
        widget.title,
        style: TextStyle(
          fontWeight: widget.isPriority ? FontWeight.bold : FontWeight.normal,
          decoration: widget.isPriority ? TextDecoration.underline : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditDialog,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onDismiss,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }
}