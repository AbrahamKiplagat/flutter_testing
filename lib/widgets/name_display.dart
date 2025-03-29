import 'package:flutter/material.dart';

class NameDisplay extends StatelessWidget {
  final String name;

  const NameDisplay({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(name, key: Key('name_text'));
  }
}
