import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/main.dart';

void main() {
  testWidgets('Button click updates text', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: ButtonWidget()));

    // Verify initial state
    expect(find.text('Press me'), findsOneWidget);
    expect(find.text('Button Clicked!'), findsNothing);

    // Tap the button
    await tester.tap(find.byKey(Key('clickButton')));
    await tester.pump(); // Rebuild the UI after state change

    // Verify text update
    expect(find.text('Press me'), findsNothing);
    expect(find.text('Button Clicked!'), findsOneWidget);
  });
}
