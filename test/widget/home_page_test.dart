import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:testing/widgets/home_page.dart';
// import 'package:testing/pages/home_page.dart';

void main() {
  testWidgets('Check if MyHomePage has correct text and button', (WidgetTester tester) async {
    // Build the MyHomePage widget inside a MaterialApp
    await tester.pumpWidget(MaterialApp(home: MyHomePage()));

    // Ensure the initial text is visible
    expect(find.text("Initial Text"), findsOneWidget);

    // Ensure the button is found by key
    final buttonFinder = find.byKey(Key('change_text_button'));
    expect(buttonFinder, findsOneWidget); // ✅ Fixes the "0 widgets found" issue

    // Tap the button
    await tester.tap(buttonFinder);
    await tester.pump();

    // Verify text changed after button press
    expect(find.text("Text Changed"), findsOneWidget);
  });
}
