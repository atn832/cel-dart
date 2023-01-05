import 'package:cel/src/interpreter/attribute_factory.dart';

import '../cel/expr.dart';
import 'interpretable.dart';

// Port of
// https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go.
class Planner {
  Planner({required this.attributeFactory});

  final AttributeFactory attributeFactory;

  Interpretable plan(Expr expression) {
    if (expression is ConstExpression) {
      return planConst(expression);
    }
    if (expression is IdentExpr) {
      return planIdent(expression);
    }
    throw Exception('Unsupported Expression type: ${expression.runtimeType}.');
  }

  Interpretable planIdent(IdentExpr ident) {
    return AttributeValueInterpretable(
        attributeFactory.maybeAttribute(ident.name));
  }
}

Interpretable planConst(ConstExpression constant) {
  return InterpretableConst(constant.value);
}
