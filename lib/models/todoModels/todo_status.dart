import 'package:flutter/material.dart';

enum TodoStatus {
  planning('Planning', Colors.grey),
  inProgress('In Progress', Colors.orange),
  done('Done', Colors.green);

  final String text;
  final Color color;
  const TodoStatus(this.text, this.color);
}