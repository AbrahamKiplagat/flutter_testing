import 'package:flutter/material.dart';

class NameButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NameButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text("Change Name"),
    );
  }
}
