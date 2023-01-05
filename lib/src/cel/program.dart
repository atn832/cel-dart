import 'package:cel/src/cel/activation.dart';
import 'package:cel/src/cel/checked_expression.dart';

import 'ast.dart';
import 'environment.dart';
import 'interpretable.dart';
import 'interpreter.dart';

class Program {
  // Port of
  // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/cel/program.go#L150.
  Program(this.environment, this.ast) {
    interpreter = Interpreter();
    // TODO: implement Dispatcher to support Function calls.
    // TODO: implement AttributeFactory to support global variables.
    // See https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/interpreter/attributes.go#L30.

    // Skipped porting Decorators and other optimizations.
    _initInterpretable();
  }

  final Environment environment;
  final Ast ast;
  late Interpreter interpreter;
  late Interpretable interpretable;

  dynamic evaluate(Map<String, dynamic> input) {
    // Skipped Pools since there is no concurrency in this implementation.
    final Activation vars = EvalActivation()..input = input;
    return interpretable.evaluate(vars);
  }

  void _initInterpretable() {
    final checkedExpression = astToCheckedExpr(ast);
    interpretable = interpreter.interpet(checkedExpression);
  }
}

CheckedExpression astToCheckedExpr(Ast ast) {
  return CheckedExpression()..expression = ast.expression;
}
