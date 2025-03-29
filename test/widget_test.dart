import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/mywidget.dart';

void main() {
  testWidgets('MyWidget has a name', (WidgetTester tester) async {
    // Build MyWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyWidget(),
        ),
      ),
    );

    // Verify MyWidget displays the correct text
    expect(find.text('Kiplagat Kurere'), findsOneWidget);
  });
}
