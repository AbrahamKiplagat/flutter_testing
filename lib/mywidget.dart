import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = "Kiplagat Kurere"; // Fixed null issue
    return Text(name);
  }
}
