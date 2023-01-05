import 'package:cel/cel.dart';
import 'package:cel/src/expr/expr.dart';
import 'package:test/test.dart';

void main() {
  group('parser', () {
    final p = Parser();

    setUp(() {
      // Additional setup goes here.
    });

    test('String', () {
      final expression = p.parse('"Hello World!"');
      expect(expression, StringLiteralExpr()..value = 'Hello World!');
    });

    // TODO: Support BoolTrueContext.
    test('Booleans', () {
      final expression = p.parse("true");
      print(expression);
    });

    test('ConditionalOr', () {
      final expression = p.parse('"admin" || "test"');
      expect(
          expression,
          CallExpr()
            ..function = '_||_'
            ..target = null
            ..args = [
              StringLiteralExpr()..value = 'admin',
              StringLiteralExpr()..value = 'test'
            ]);
    });
  });
}
