import 'package:cel/src/cel/interpretable.dart';
import 'package:cel/src/cel/planner.dart';

import 'checked_expression.dart';

class Interpreter {
  Interpretable interpet(CheckedExpression checkedExpression) {
    final p = Planner();
    return p.plan(checkedExpression.expression);
  }
}
