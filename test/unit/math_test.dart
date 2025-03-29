// test/unit/math_test.dart
import 'package:flutter_test/flutter_test.dart';

int add(int a, int b) => a + b;
int subtract(int a, int b) => a - b;
int multiply(int a, int b) => a * b;

double divide(int a, int b) {
  if (b == 0) throw ArgumentError('Cannot divide by zero');
  return a / b;
}

void main() {
  group('Math Operations Test', () {
    test('Addition Test', () {
      expect(add(2, 3), 5);
    });

    test('Subtraction Test', () {
      expect(subtract(5, 2), 3);
    });

    test('Multiplication Test', () {
      expect(multiply(3, 4), 12);
    });

    test('Division Test', () {
      expect(divide(10, 2), 5);
    });

    test('Division by Zero Test', () {
      expect(() => divide(5, 0), throwsArgumentError);
    });
  });
}
