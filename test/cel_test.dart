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

    test('Booleans', () {
      expect(p.parse('true'), BoolLiteralExpr()..value = true);
      expect(p.parse('false'), BoolLiteralExpr()..value = false);
    });

    test('Null', () {
      expect(p.parse(('null')), NullLiteralExpr());
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

    test('Ident', () {
      final expression = p.parse('request');
      expect(expression, IdentExpr()..name = 'request');
    });

    test('Select', () {
      final expression = p.parse('request.auth.claims.group');
      expect(
          expression,
          SelectExpr()
            ..field = 'group'
            ..operand = (SelectExpr()
              ..field = 'claims'
              ..operand = (SelectExpr()
                ..field = 'auth'
                ..operand = (IdentExpr()..name = 'request'))));
    });

    test('Operators', () {
      final expression = p.parse("request.auth.uid == 'abc'");
      expect(
          expression,
          CallExpr()
            ..function = '_==_'
            ..target = null
            ..args = [
              SelectExpr()
                ..field = 'uid'
                ..operand = (SelectExpr()
                  ..field = 'auth'
                  ..operand = (IdentExpr()..name = 'request')),
              StringLiteralExpr()..value = 'abc'
            ]);
    });
  });
}
