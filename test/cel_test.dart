import 'dart:math';

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
  });
}
