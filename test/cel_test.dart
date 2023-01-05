import 'package:cel/cel.dart';
import 'package:cel/src/cel/environment.dart';
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

    test('Int', () {
      expect(p.parse('13'), IntLiteralExpr()..value = 13);
      expect(p.parse('-4'), IntLiteralExpr()..value = -4);
      expect(p.parse('0xa'), IntLiteralExpr()..value = 10);
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

  group('program', () {
    test('Const', () {
      final environment = Environment();
      final ast = environment.compile('true');
      final p = Program(environment, ast);
      expect(p.evaluate({}), true);
    });

    test('Ident', () {
      final environment = Environment();
      final ast = environment.compile('animal');
      final p = Program(environment, ast);
      expect(p.evaluate({'animal': 'elephant'}), 'elephant');
    });
    test('==', () {
      final environment = Environment();
      final ast = environment.compile('uid=="abc"');
      final p = Program(environment, ast);
      expect(p.evaluate({'uid': 'abc'}), true);
      expect(p.evaluate({'uid': 'def'}), false);
    });
    test('Select and Qualifiers', () {
      final environment = Environment();
      final ast = environment.compile('user.uid=="abc"');
      final p = Program(environment, ast);
      expect(
          p.evaluate({
            'user': {'uid': 'abc'}
          }),
          true);
    });
    test('Null and LogicalAnd', () {
      final environment = Environment();
      final ast = environment
          .compile('request.auth != null && request.auth.uid == "abc"');
      final p = Program(environment, ast);

      expect(p.evaluate({'request': {}}), false);
      expect(
          p.evaluate({
            'request': {
              'auth': {'uid': 'DEF'}
            }
          }),
          false);
      expect(
          p.evaluate({
            'request': {
              'auth': {'uid': 'abc'}
            }
          }),
          true);
    });
    test('LogicalOr', () {
      final environment = Environment();
      final ast = environment.compile('0 == 1 || true');
      final p = Program(environment, ast);
      expect(p.evaluate({}), true);
    });
  });
}
