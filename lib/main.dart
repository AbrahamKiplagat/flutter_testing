// lib/main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = "Kiplagat Kurere";

  void changeName() {
    setState(() {
      name = "New Name";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Test Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, key: Key("name_text")),
            SizedBox(height: 20),
            ElevatedButton(
              key: Key("change_text_button"),
              onPressed: changeName,
              child: Text("Change Name"),
            )
          ],
        ),
      ),
    );
  }
}
