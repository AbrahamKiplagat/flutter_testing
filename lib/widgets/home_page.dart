import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String buttonText = "Initial Text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(buttonText),
            ElevatedButton(
              key: Key('change_text_button'), // ✅ Ensure this matches the test
              onPressed: () {
                setState(() {
                  buttonText = "Text Changed";
                });
              },
              child: Text("Change Text"),
            ),
          ],
        ),
      ),
    );
  }
}
