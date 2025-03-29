import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:testing/widgets/name_display.dart';

void main() {
  testWidgets('NameDisplay displays the correct name', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NameDisplay(name: "Kiplagat Kurere"),
    ));

    expect(find.text("Kiplagat Kurere"), findsOneWidget);
  });
}
