import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:testing/widgets/name_button.dart';

void main() {
  testWidgets('NameButton calls onPressed when tapped', (WidgetTester tester) async {
    bool wasPressed = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NameButton(
          key: Key('name_button_widget'), // Changed Key to avoid conflicts
          onPressed: () {
            wasPressed = true;
          },
        ),
      ),
    ));

    // Verify initial state
    expect(wasPressed, false);

    // Tap the button by finding NameButton directly
    await tester.tap(find.byType(NameButton));
    await tester.pump();

    // Verify button press callback was triggered
    expect(wasPressed, true);
  });
}
