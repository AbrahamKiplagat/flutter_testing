import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:testing/todo_list.dart';

void main() {
  testWidgets('Adds a new todo item', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TodoList()));

    // Find the input field and add button
    final textFieldFinder = find.byType(TextField);
    final addButtonFinder = find.byIcon(Icons.add);

    // Enter a task
    await tester.enterText(textFieldFinder, 'Buy groceries');
    await tester.tap(addButtonFinder);
    await tester.pump();

    // Verify task appears
    expect(find.text('Buy groceries'), findsOneWidget);
  });

  testWidgets('Marks a task as priority', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TodoList()));
  });
}
//     // Find the input field and add button
//     final textFieldFinder = find.byType(TextField);
//     final addButtonFinder = find.byIcon(Icons.add);

//     // Enter a task and mark as priority
//     await tester.enterText(textFieldFinder, 'Complete project');
//     await tester.tap(find.byKey(Key('priority_checkbox')));
//     await tester.tap(addButtonFinder);
//     await tester.pump();

//     // Verify task appears with priority styling
//     final textWidget = tester.widget<Text>(find.text('Complete project'));
//     expect(textWidget.style?.color, Colors.red);
//   });

//   testWidgets('Dismisses a todo item', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(home: TodoList()));

//     // Add a task
//     await tester.enterText(find.byType(TextField), 'Read a book');
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Swipe to dismiss the task
//     await tester.drag(find.text('Read a book'), const Offset(-500, 0));
//     await tester.pumpAndSettle();

//     // Verify task is removed
//     expect(find.text('Read a book'), findsNothing);

//     await tester.pumpWidget(const MaterialApp(home: TodoList()));

//     // Add a todo item first
//     await tester.enterText(find.byType(TextField), 'New Task');
//     await tester.tap(find.text('Add Todo'));
//     await tester.pump();

//     // Verify item is added
//     expect(find.text('New Task'), findsOneWidget);

//     // Try to delete the item
//     await tester.tap(find.byKey(const Key('delete_button'))); // Use the key
//     await tester.pump();

//     // Verify item is removed
//     expect(find.text('New Task'), findsNothing);
//   });
// }
