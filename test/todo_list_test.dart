import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/todo_list_screen.dart';

void main() {
  testWidgets("Todo List UI Test", (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: TodoListScreen()));

    // Find widgets
    final textField = find.byType(TextField);
    final addButton = find.byKey(const Key('add_button'));

    // Verify initial state
    expect(find.byType(ListTile), findsNothing);

    // Enter text and add todo
    await tester.enterText(textField, "Test Todo");
    await tester.tap(addButton);
    await tester.pump();

    // Verify the todo is added
    expect(find.text("Test Todo"), findsOneWidget);

    // Dismiss the todo (swipe away)
    await tester.drag(find.text("Test Todo"), const Offset(-500, 0));
    await tester.pumpAndSettle();

    // Verify the todo is removed
    expect(find.text("Test Todo"), findsNothing);
  });
}
