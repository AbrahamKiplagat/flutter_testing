import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing/models/todoModels/todo_status.dart';
import 'package:testing/widgets/chooseColor/color_picker.dart';

class TodoItem extends StatefulWidget {
  final String title;
  final String description;
  final DateTime startDate;
  final TodoStatus status;
  final bool isPriority;
  final Color color;
  final VoidCallback onDismiss;
  final Function(String, String, DateTime, TodoStatus, bool, Color) onEdit;

  const TodoItem({
    super.key,
    required this.title,
    required this.description,
    required this.startDate,
    required this.status,
    required this.isPriority,
    required this.color,
    required this.onDismiss,
    required this.onEdit,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late DateTime _selectedDate;
  late TodoStatus _currentStatus;
  late bool _currentPriority;
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descController = TextEditingController(text: widget.description);
    _selectedDate = widget.startDate;
    _currentStatus = widget.status;
    _currentPriority = widget.isPriority;
    _currentColor = widget.color;
  }

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

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Todo'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              ListTile(
                title: Text(DateFormat('MMM dd, yyyy').format(_selectedDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              DropdownButtonFormField<TodoStatus>(
                value: _currentStatus,
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
                onChanged: (value) => setState(() => _currentStatus = value!),
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
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onEdit(
                _titleController.text,
                _descController.text,
                _selectedDate,
                _currentStatus,
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
    return Card(
      color: _currentColor.withOpacity(0.3), // Use the selected color with opacity
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: widget.isPriority ? FontWeight.bold : FontWeight.normal,
                decoration: widget.isPriority ? TextDecoration.underline : null,
              ),
            ),
            if (widget.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    color: widget.status.color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('MMM dd, yyyy').format(widget.startDate),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
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
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
}