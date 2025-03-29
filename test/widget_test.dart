import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/main.dart'; // Ensure correct import

void main() {
  testWidgets('Main widget displays name', (WidgetTester tester) async {
    // Build MyApp
    await tester.pumpWidget(MyApp());

    // Verify Main displays the correct text
    expect(find.text('Kiplagat Kurere'), findsOneWidget);
  });
}
