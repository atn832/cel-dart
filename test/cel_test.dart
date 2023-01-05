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
      expect(p.parse('"Hello World!"'), isA<StringLiteralExpr>());
    });
  });
}
