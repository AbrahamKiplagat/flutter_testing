import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final bool isPriority;
  final VoidCallback onDismiss;

  const TodoItem({
    super.key,
    required this.title,
    required this.isPriority,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: isPriority
            ? const Icon(Icons.priority_high, color: Colors.red)
            : null,
        trailing: IconButton(
          key: const Key('delete_button'), // Add a key for testing
          icon: const Icon(Icons.delete),
          onPressed: onDismiss,
        ),
      ),
    );
  }
}
