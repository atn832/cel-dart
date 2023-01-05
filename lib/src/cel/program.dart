import 'package:cel/src/interpreter/attribute_factory.dart';

import '../interpreter/activation.dart';
import '../interpreter/interpretable.dart';
import '../interpreter/interpreter.dart';
import 'ast.dart';
import 'checked_expression.dart';
import 'environment.dart';

class Program {
  // Port of
  // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/cel/program.go#L150.
  Program(this.environment, this.ast) {
    // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/cel/program.go#L183-L190
    final attributeFactory = AttributeFactory();
    interpreter = Interpreter(attributeFactory: attributeFactory);

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
    // Skipped porting Pools since there is no concurrency in this
    // implementation.
    final Activation vars = EvalActivation(input);
    return interpretable.evaluate(vars);
  }

  void _initInterpretable() {
    final checkedExpression = astToCheckedExpr(ast);
    interpretable = interpreter.interpet(checkedExpression);
  }
}

CheckedExpression astToCheckedExpr(Ast ast) {
  return CheckedExpression(ast.expression);
}
