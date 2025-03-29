### find if there is  a ready declared name on a widget:
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = "Kiplagat Kurere"; // Fixed null issue
    return Text(name);
  }
}
### test code:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/main.dart';

void main() {
  testWidgets('MyWidget has a name', (WidgetTester tester) async {
    // Build MyWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Main(),
        ),
      ),
    );

    // Verify MyWidget displays the correct text
    expect(find.text('Kiplagat Kurere'), findsOneWidget);
  });
}
