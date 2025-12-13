import 'package:cel/cel.dart';
import 'package:cel/src/cel/expr.dart';
import 'package:cel/src/parser/bitwise.dart';
import 'package:cel/src/parser/parser.dart';
import 'package:test/test.dart';

void main() {
  group('parser', () {
    final p = Parser();

    test('String', () {
      expect(p.parse('"Hello World!"'), StringLiteralExpr('Hello World!'));
      expect(p.parse("'Hello World!'"), StringLiteralExpr('Hello World!'));
    });

    test('Booleans', () {
      expect(p.parse('true'), BoolLiteralExpr(true));
      expect(p.parse('false'), BoolLiteralExpr(false));
    });

    test('Int', () {
      expect(p.parse('13'), IntLiteralExpr(13));
      expect(p.parse('-4'), IntLiteralExpr(-4));
      expect(p.parse('0xa'), IntLiteralExpr(10));
    });

    test('Uint', () {
      expect(p.parse('13u'), IntLiteralExpr(13));
    });

    test('Double', () {
      expect(p.parse('13.3'), DoubleLiteralExpr(13.3));
    });

    test('Null', () {
      expect(p.parse(('null')), NullLiteralExpr());
    });

    test('Bytes', () {
      expect(p.parse('b"abc"'), BytesLiteralExpr([97, 98, 99]));
    });

    test('ConditionalOr', () {
      expect(
          p.parse('"admin" || "test"'),
          CallExpr(
              function: '_||_',
              args: [StringLiteralExpr('admin'), StringLiteralExpr('test')]));
    });

    test('Ident', () {
      expect(p.parse('request'), IdentExpr('request'));
    });

    test('Select', () {
      expect(
          p.parse('request.auth.claims.group'),
          SelectExpr(
              field: 'group',
              operand: (SelectExpr(
                  field: 'claims',
                  operand: (SelectExpr(
                      field: 'auth', operand: (IdentExpr('request'))))))));
    });

    test('Operators', () {
      expect(
          p.parse("request.auth.uid == 'abc'"),
          CallExpr(function: '_==_', args: [
            SelectExpr(
                field: 'uid',
                operand:
                    (SelectExpr(field: 'auth', operand: IdentExpr('request')))),
            StringLiteralExpr('abc')
          ]));
    });

    test('LogicalAnd', () {
      expect(
          p.parse('request.auth != null && request.auth.uid == userId'),
          CallExpr(function: '_&&_', args: [
            CallExpr(function: '_!=_', args: [
              SelectExpr(field: 'auth', operand: IdentExpr('request')),
              NullLiteralExpr()
            ]),
            CallExpr(function: '_==_', args: [
              SelectExpr(
                  field: 'uid',
                  operand:
                      SelectExpr(field: 'auth', operand: IdentExpr('request'))),
              IdentExpr('userId')
            ])
          ]));
    });
  });

  group('program', () {
    test('Const', () {
      final environment = Environment.standard();
      final ast = environment.compile('true');
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), true);
    });

    test('Ident', () {
      final environment = Environment.standard();
      final ast = environment.compile('animal');
      final p = environment.makeProgram(ast);
      expect(p.evaluate({'animal': 'elephant'}), 'elephant');
    });
    test('==', () {
      final environment = Environment.standard();
      final ast = environment.compile('uid=="abc"');
      final p = environment.makeProgram(ast);
      expect(p.evaluate({'uid': 'abc'}), true);
      expect(p.evaluate({'uid': 'def'}), false);
    });
    test('Select and Qualifiers', () {
      final environment = Environment.standard();
      final ast = environment.compile('user.uid=="abc"');
      final p = environment.makeProgram(ast);
      expect(
          p.evaluate({
            'user': {'uid': 'abc'}
          }),
          true);
    });
    test('Null and LogicalAnd', () {
      final environment = Environment.standard();
      final ast = environment
          .compile('request.auth != null && request.auth.uid == "abc"');
      final p = environment.makeProgram(ast);

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
    test('LogicalAnd (variadic)', () {
      final environment = Environment.standard();
      final ast = environment.compile(
          'request != null && request.auth != null && request.auth.uid == "abc"');
      final p = environment.makeProgram(ast);

      expect(p.evaluate({'request': null}), false);
      expect(p.evaluate({'request': {}}), false);
      expect(
          p.evaluate({
            'request': {'auth': null}
          }),
          false);
      expect(
          p.evaluate({
            'request': {
              'auth': {'something': 123}
            }
          }),
          false);
      expect(
          p.evaluate({
            'request': {
              'auth': {'uid': 123}
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
      final environment = Environment.standard();
      final ast = environment.compile('0 == 1 || true');
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), true);
    });
    test('LogicalOr (variadic)', () {
      final environment = Environment.standard();
      final ast = environment.compile('0 == 1 || 1 > 3 || false');
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), false);
    });
    group('Comparisons', () {
      group('<', () {
        test('int', () {
          final environment = Environment.standard();
          final ast = environment.compile('value < 1');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), true);
          expect(p.evaluate({'value': 1}), false);
          expect(p.evaluate({'value': 2}), false);
        });
        test('double', () {
          final environment = Environment.standard();
          final ast = environment.compile('value < 1.5');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), true);
          expect(p.evaluate({'value': 1}), true);
          expect(p.evaluate({'value': 2}), false);
        });
        test('uint', () {
          final environment = Environment.standard();
          final ast = environment.compile('value < 1u');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), true);
          expect(p.evaluate({'value': 1}), false);
          expect(p.evaluate({'value': 2}), false);
        });
        test('bool', () {
          final environment = Environment.standard();
          final ast = environment.compile('value < true');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': false}), true);
          expect(p.evaluate({'value': true}), false);
        });
        test('string', () {
          final environment = Environment.standard();
          final ast = environment.compile('value < "basket"');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 'alpha'}), true);
          expect(p.evaluate({'value': 'basket'}), false);
          expect(p.evaluate({'value': 'casket'}), false);
        });
      });
      group('<=', () {
        test('int', () {
          final environment = Environment.standard();
          final ast = environment.compile('value <= 1');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), true);
          expect(p.evaluate({'value': 1}), true);
          expect(p.evaluate({'value': 2}), false);
        });
        test('double', () {
          final environment = Environment.standard();
          final ast = environment.compile('value <= 1.5');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), true);
          expect(p.evaluate({'value': 1.5}), true);
          expect(p.evaluate({'value': 2}), false);
        });
        test('uint', () {
          final environment = Environment.standard();
          final ast = environment.compile('value <= 1u');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), true);
          expect(p.evaluate({'value': 1}), true);
          expect(p.evaluate({'value': 2}), false);
        });
        test('bool', () {
          final environment = Environment.standard();
          final ast = environment.compile('value <= true');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': false}), true);
          expect(p.evaluate({'value': true}), true);
        });
        test('string', () {
          final environment = Environment.standard();
          final ast = environment.compile('value <= "basket"');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 'alpha'}), true);
          expect(p.evaluate({'value': 'basker'}), true);
          expect(p.evaluate({'value': 'basket'}), true);
        });
      });
      group('>', () {
        test('int', () {
          final environment = Environment.standard();
          final ast = environment.compile('value > 1');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), false);
          expect(p.evaluate({'value': 1}), false);
          expect(p.evaluate({'value': 2}), true);
        });
        test('double', () {
          final environment = Environment.standard();
          final ast = environment.compile('value > 1.5');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), false);
          expect(p.evaluate({'value': 1}), false);
          expect(p.evaluate({'value': 2}), true);
        });
        test('uint', () {
          final environment = Environment.standard();
          final ast = environment.compile('value > 1u');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), false);
          expect(p.evaluate({'value': 1}), false);
          expect(p.evaluate({'value': 2}), true);
        });
        test('bool', () {
          final environment = Environment.standard();
          final ast = environment.compile('value > true');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': false}), false);
          expect(p.evaluate({'value': true}), false);
        });
        test('string', () {
          final environment = Environment.standard();
          final ast = environment.compile('value > "basket"');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 'alpha'}), false);
          expect(p.evaluate({'value': 'basket'}), false);
          expect(p.evaluate({'value': 'casket'}), true);
        });
      });
      group('>=', () {
        test('int', () {
          final environment = Environment.standard();
          final ast = environment.compile('value >= 1');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), false);
          expect(p.evaluate({'value': 1}), true);
          expect(p.evaluate({'value': 2}), true);
        });
        test('double', () {
          final environment = Environment.standard();
          final ast = environment.compile('value >= 1.5');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), false);
          expect(p.evaluate({'value': 1.5}), true);
          expect(p.evaluate({'value': 2}), true);
        });
        test('uint', () {
          final environment = Environment.standard();
          final ast = environment.compile('value >= 1u');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 0}), false);
          expect(p.evaluate({'value': 1}), true);
          expect(p.evaluate({'value': 2}), true);
        });
        test('bool', () {
          final environment = Environment.standard();
          final ast = environment.compile('value >= true');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': false}), false);
          expect(p.evaluate({'value': true}), true);
        });
        test('string', () {
          final environment = Environment.standard();
          final ast = environment.compile('value >= "basket"');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 'alpha'}), false);
          expect(p.evaluate({'value': 'basker'}), false);
          expect(p.evaluate({'value': 'basket'}), true);
        });
      });
    });
    group('arithmetic operations', () {
      group('+', () {
        test('int', () {
          final environment = Environment.standard();
          final ast = environment.compile('1 + 1');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), 2);
        });
        test('uint', () {
          final environment = Environment.standard();
          final ast = environment.compile('145u + 12u');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), 157);
        });
        test('double', () {
          final environment = Environment.standard();
          final ast = environment.compile('1.5 + 1.1');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), 2.6);
        });
        test('string', () {
          final environment = Environment.standard();
          final ast = environment.compile('"ab" + "cd"');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), 'abcd');
        });
        test('bytes concatenation is not supported', () {
          final environment = Environment.standard();
          final ast = environment.compile('b"ab" + b"cd"');
          expect(() {
            final p = environment.makeProgram(ast);
            p.evaluate({});
          }, throwsUnimplementedError);
        });
        test('lists', () {
          final environment = Environment.standard();
          final ast = environment.compile('[1] + [2, 3]');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), [1, 2, 3]);
        });
      });
      group('-', () {
        test('double', () {
          final environment = Environment.standard();
          final ast = environment.compile('1.5 - 2');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), -.5);
        });
        test('int', () {
          final environment = Environment.standard();
          final ast = environment.compile('15 - 2');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), 13);
        });
        test('uint', () {
          final environment = Environment.standard();
          final ast = environment.compile('15u - 2u');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), 13);
        });
      });
      group('Multiply', () {
        test('double', () {
          final environment = Environment.standard();
          final ast = environment.compile('-1.5 * 2');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), -3);
        });
        test('int', () {
          final environment = Environment.standard();
          final ast = environment.compile('-15 * 2');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), -30);
        });
        test('uint', () {
          final environment = Environment.standard();
          final ast = environment.compile('15u * 2u');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), 30);
        });
      });
      group('Divide', () {
        test('int', () {
          final environment = Environment.standard();
          final ast = environment.compile('27 / 10');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), 2);
        });
        test('double', () {
          final environment = Environment.standard();
          final ast = environment.compile('27.5 / 10.');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), 2.75);
        });
        test('uint', () {
          final environment = Environment.standard();
          final ast = environment.compile('27u / 10u');
          final p = environment.makeProgram(ast);
          expect(p.evaluate({}), 2);
        });
      });
      test('Modulo', () {
        final environment = Environment.standard();
        final ast = environment.compile('27 % 10');
        final p = environment.makeProgram(ast);
        expect(p.evaluate({}), 7);
      });
    });
    test('! unary', () {
      final environment = Environment.standard();
      final ast = environment.compile('!true');
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), false);
    });
    test('list', () {
      final environment = Environment.standard();
      final ast = environment.compile('[1, 2, value]');
      final p = environment.makeProgram(ast);
      expect(p.evaluate({'value': 3}), [1, 2, 3]);
    });
    test('map', () {
      final environment = Environment.standard();
      final ast = environment.compile("{'name': 'cel', 'useful': true, 5: 7}");
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), {'name': 'cel', 'useful': true, 5: 7});
    });
    test('index a list', () {
      final environment = Environment.standard();
      final ast = environment.compile('[1, 2, value][2]');
      final p = environment.makeProgram(ast);
      expect(p.evaluate({'value': 3}), 3);
    });
    test('index a map', () {
      final environment = Environment.standard();
      final ast =
          environment.compile("{'name': 'cel', 'useful': true, 5: 7}['name']");
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), 'cel');
    });
    group('existence in list', () {
      test('int', () {
        final environment = Environment.standard();
        final ast = environment.compile('value in [1, 2]');
        final p = environment.makeProgram(ast);
        expect(p.evaluate({'value': 1}), true);
        expect(p.evaluate({'value': 3}), false);
      });
      group('string', () {
        test('with hard coded list', () {
          final environment = Environment.standard();
          final ast = environment.compile("value in ['london', 'paris']");
          final p = environment.makeProgram(ast);
          expect(p.evaluate({'value': 'london'}), true);
          expect(p.evaluate({'value': 'stockholm'}), false);
        });
        test('with variable list', () {
          final environment = Environment.standard();
          final ast = environment.compile("value in cities");
          final p = environment.makeProgram(ast);
          expect(
              p.evaluate({
                'value': 'london',
                'cities': ['london', 'paris']
              }),
              true);
          expect(
              p.evaluate({
                'value': 'stockholm',
                'cities': ['london', 'paris']
              }),
              false);
        });
      });
    });
    test('existence a map', () {
      final environment = Environment.standard();
      final ast =
          environment.compile("key in {'name': 'cel', 'useful': true, 5: 7}");
      final p = environment.makeProgram(ast);
      expect(p.evaluate({'key': 'name'}), true);
      expect(p.evaluate({'key': 'description'}), false);
    });
    test('ternary operator', () {
      final environment = Environment.standard();
      final ast = environment.compile("true ? 1: -1");
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), 1);
    });
    test('a.matches(b)', () {
      final environment = Environment.standard();
      final ast = environment.compile("'hello'.matches('he')");
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), true);
    });
    test('a.matches(b)', () {
      final environment = Environment.standard();
      final ast = environment.compile("'hello world'.matches('[a-z]+ .*')");
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), true);
    });
    test('matches(a, b)', () {
      final environment = Environment.standard();
      final ast = environment.compile("matches('hello', 'he')");
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), true);
    });
    test('startsWith', () {
      final environment = Environment.standard();
      final ast = environment.compile("'hello'.startsWith('he')");
      final p = environment.makeProgram(ast);
      expect(p.evaluate({}), true);
    });
    test('endsWith', () {
      final environment = Environment.standard();
      final ast = environment.compile("value.endsWith('lo')");
      final p = environment.makeProgram(ast);
      expect(p.evaluate({'value': 'hello'}), true);
      expect(p.evaluate({'value': 'low'}), false);
    });
    test('contains', () {
      final environment = Environment.standard();
      final ast = environment.compile("value.contains('are')");
      final p = environment.makeProgram(ast);
      expect(p.evaluate({'value': 'rare'}), true);
      expect(p.evaluate({'value': 'donut'}), false);
    });
  });

  test('bitwise and', () {
    expect(bitwiseAnd(35, 283), 35 & 283);
    expect(bitwiseAnd(1 << 34, 135763153920), 1 << 34 & 135763153920);
  });
}
