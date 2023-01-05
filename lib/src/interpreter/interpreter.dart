import '../cel/checked_expression.dart';
import 'interpretable.dart';
import 'planner.dart';

class Interpreter {
  Interpretable interpet(CheckedExpression checkedExpression) {
    final p = Planner();
    return p.plan(checkedExpression.expression);
  }
}
