import '../cel/expr.dart';
import '../operators/operators.dart';
import 'attribute_factory.dart';
import 'dispatcher.dart';
import 'functions/functions.dart';
import 'interpretable.dart';

// Port of
// https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go.
class Planner {
  Planner({required this.attributeFactory, required this.dispatcher});

  final AttributeFactory attributeFactory;
  final Dispatcher dispatcher;

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
    if (expression is ListExpr) {
      return planCreateList(expression);
    }
    throw Exception('Unsupported Expression type: ${expression.runtimeType}.');
  }

  Interpretable planIdent(IdentExpr ident) {
    return AttributeValueInterpretable(
        attributeFactory.maybeAttribute(ident.name));
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L239
  Interpretable planCall(CallExpr expression) {
    final functionName = expression.function;
    // Skip target, p.resolveFunction.
    final interpretableArguments = expression.args.map((e) => plan(e)).toList();
    if (functionName == Operators.logicalAnd.name) {
      return planCallLogicalAnd(expression, interpretableArguments);
    }
    if (functionName == Operators.logicalOr.name) {
      return planCallLogicalOr(expression, interpretableArguments);
    }
    if (functionName == Operators.equals.name) {
      return planCallEqual(expression, interpretableArguments);
    }
    if (functionName == Operators.notEquals.name) {
      return planCallNotEqual(expression, interpretableArguments);
    }
    // TODO: implement indexer, optSelect, optIndex.

    final functionImplementation = dispatcher.findOverload(functionName);
    if (functionImplementation == null) {
      throw StateError('Missing function $functionName');
    }
    switch (expression.args.length) {
      // TODO: handle zero functions.
      case 1:
        return planCallUnary(expression, functionName, functionImplementation,
            interpretableArguments);
      case 2:
        return planCallBinary(expression, functionName, functionImplementation,
            interpretableArguments);
      default:
        throw UnsupportedError(
            "Function $functionName. Only Binary functions are supported for now.");
    }
  }

  Interpretable planCallLogicalAnd(
      CallExpr expression, List<Interpretable> interpretableArguments) {
    return LogicalAndInterpretable(
        interpretableArguments[0], interpretableArguments[1]);
  }

  Interpretable planCallLogicalOr(
      CallExpr expression, List<Interpretable> interpretableArguments) {
    return LogicalOrInterpretable(
        interpretableArguments[0], interpretableArguments[1]);
  }

  Interpretable planCallEqual(
      CallExpr expression, List<Interpretable> interpretableArguments) {
    return EqualInterpretable(
        interpretableArguments[0], interpretableArguments[1]);
  }

  Interpretable planCallNotEqual(
      CallExpr expression, List<Interpretable> interpretableArguments) {
    return NotEqualInterpretable(
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

  Interpretable planCallBinary(CallExpr expression, String functionName,
      Overload functionImplementation, List<Interpretable> arguments) {
    return BinaryInterpretable(
        functionImplementation.binaryOperator!, arguments[0], arguments[1]);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L516
  Interpretable planCreateList(ListExpr expression) {
    final elements = expression.elements.map((e) => plan(e)).toList();
    return ListInterpretable(elements);
  }

  Interpretable planCallUnary(CallExpr expression, String functionName,
      Overload functionImplementation, List<Interpretable> arguments) {
    return UnaryInterpretable(
        functionImplementation.unaryOperator!, arguments[0]);
  }
}

Interpretable planConst(ConstExpression constant) {
  return InterpretableConst(constant.value);
}
