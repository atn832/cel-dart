import 'package:cel/cel.dart';
import 'package:cel/src/cel/expr.dart';
import 'package:test/test.dart';

void main() {
  group('parser', () {
    final p = Parser();

    test('String', () {
      expect(p.parse('"Hello World!"'),
          StringLiteralExpr()..value = 'Hello World!');
    });

    test('Booleans', () {
      expect(p.parse('true'), BoolLiteralExpr()..value = true);
      expect(p.parse('false'), BoolLiteralExpr()..value = false);
    });

    test('Null', () {
      expect(p.parse(('null')), NullLiteralExpr());
    });

    test('ConditionalOr', () {
      expect(
          p.parse('"admin" || "test"'),
          CallExpr()
            ..function = '_||_'
            ..target = null
            ..args = [
              StringLiteralExpr()..value = 'admin',
              StringLiteralExpr()..value = 'test'
            ]);
    });

    test('Ident', () {
      expect(p.parse('request'), IdentExpr()..name = 'request');
    });

    test('Select', () {
      expect(
          p.parse('request.auth.claims.group'),
          SelectExpr()
            ..field = 'group'
            ..operand = (SelectExpr()
              ..field = 'claims'
              ..operand = (SelectExpr()
                ..field = 'auth'
                ..operand = (IdentExpr()..name = 'request'))));
    });

    test('Operators', () {
      expect(
          p.parse("request.auth.uid == 'abc'"),
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

    test('LogicalAnd', () {
      expect(
          p.parse('request.auth != null && request.auth.uid == userId'),
          CallExpr()
            ..function = '_&&_'
            ..target = null
            ..args = [
              CallExpr()
                ..function = '_!=_'
                ..target = null
                ..args = [
                  SelectExpr()
                    ..field = 'auth'
                    ..operand = (IdentExpr()..name = 'request'),
                  NullLiteralExpr()
                ],
              CallExpr()
                ..function = '_==_'
                ..target = null
                ..args = [
                  SelectExpr()
                    ..field = 'uid'
                    ..operand = (SelectExpr()
                      ..field = 'auth'
                      ..operand = (IdentExpr()..name = 'request')),
                  IdentExpr()..name = 'userId'
                ]
            ]);
    });
  });
}
