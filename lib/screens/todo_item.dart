import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String text;
  final VoidCallback onDismissed;

  const TodoItem({super.key, required this.text, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(text),
      onDismissed: (direction) => onDismissed(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        child: ListTile(
          title: Text(text),
        ),
      ),
    );
  }
}
