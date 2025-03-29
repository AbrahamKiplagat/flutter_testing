// todo_item.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing/models/todoModels/todo_status.dart';
import 'package:testing/widgets/chooseColor/color_picker.dart';
// import '../models/todo_status.dart';

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
    elevation: 2,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: widget.isPriority 
                        ? FontWeight.bold 
                        : FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              _buildStatusIndicator(),
            ],
          ),
          if (widget.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                widget.description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 8),
              Text(
                DateFormat('MMM dd, yyyy').format(widget.startDate),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              if (widget.isPriority) _buildPriorityBadge(),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildStatusIndicator() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: widget.status.color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      widget.status.text,
      style: TextStyle(
        color: widget.status.color,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildPriorityBadge() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.red.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: Colors.red[300],
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          'High Priority',
          style: TextStyle(
            color: Colors.red[300],
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}}