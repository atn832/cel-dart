import 'package:cel/src/interpreter/attribute_factory.dart';

import '../cel/expr.dart';
import '../operators/operators.dart';
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
    if (expression is CallExpr) {
      return planCall(expression);
    }
    if (expression is SelectExpr) {
      return planSelect(expression);
    }
    throw Exception('Unsupported Expression type: ${expression.runtimeType}.');
  }

  Interpretable planIdent(IdentExpr ident) {
    return AttributeValueInterpretable(
        attributeFactory.maybeAttribute(ident.name));
  }

  Interpretable planCall(CallExpr expression) {
    final functionName = expression.function;
    // Skip target, p.resolveFunction.
    final interpretableArguments = expression.args.map((e) => plan(e)).toList();
    if (functionName == Operators.Equals.name) {
      return planCallEqual(expression, interpretableArguments);
    }
    throw UnsupportedError("Function $functionName");
  }

  Interpretable planCallEqual(
      CallExpr expression, List<Interpretable> interpretableArguments) {
    return EqualInterpretable(
        interpretableArguments[0], interpretableArguments[1]);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L179
  Interpretable planSelect(SelectExpr select) {
    final operand = plan(select.operand);

    var attribute = operand;
    if (attribute is! AttributeValueInterpretable) {
      // Set up a relative attribute.
      attribute = relativeAttribute(operand);
    }
    final qualifier = attributeFactory.qualifier(select.field);
    attribute.addQualifier(qualifier);
    return attribute;
  }

  AttributeValueInterpretable relativeAttribute(Interpretable eval) {
    return AttributeValueInterpretable(
        attributeFactory.relativeAttribute(eval));
  }
}

Interpretable planConst(ConstExpression constant) {
  return InterpretableConst(constant.value);
}
