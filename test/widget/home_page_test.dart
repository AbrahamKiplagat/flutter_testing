// test/widget/home_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/main.dart';

void main() {
  testWidgets('Check if MyHomePage has correct text and button', (tester) async {
    await tester.pumpWidget(MyApp());

    // Verify the initial text is displayed
    expect(find.text('Kiplagat Kurere'), findsOneWidget);
    expect(find.byKey(Key('change_text_button')), findsOneWidget);

    // Tap the button and trigger a state change
    await tester.tap(find.byKey(Key('change_text_button')));
    await tester.pump();

    // Verify the updated text appears
    expect(find.text('New Name'), findsOneWidget);
  });
}
