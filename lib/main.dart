import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ButtonWidget(),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  String buttonText = "Press me";

  void updateText() {
    setState(() {
      buttonText = "Button Clicked!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(buttonText, key: Key('buttonText')),
            ElevatedButton(
              key: Key('clickButton'),
              onPressed: updateText,
              child: Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }
}
