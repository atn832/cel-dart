import 'package:cel/src/parser/gen/CELParser.dart';

import '../cel/expr.dart';
import 'interpretable.dart';

// Port of
// https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go.
class Planner {
  Interpretable plan(Expr expression) {
    if (expression is ConstExpression) {
      return planConst(expression);
    }
    return Interpretable();
  }
}

Interpretable planConst(ConstExpression expression) {
  return InterpretableConst(expression.value);
}
