import 'package:cel/src/common/types/ref/provider.dart';

import '../cel/expr.dart';
import '../operators/operators.dart';
import 'attribute.dart';
import 'attribute_factory.dart';
import 'dispatcher.dart';
import 'functions/functions.dart';
import 'interpretable.dart';

// Port of
// https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go.
class Planner {
  Planner(
      {required this.attributeFactory,
      required this.dispatcher,
      required this.adapter});

  final AttributeFactory attributeFactory;
  final Dispatcher dispatcher;
  final TypeAdapter adapter;

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
    if (expression is MapExpr) {
      return planCreateMap(expression);
    }
    throw Exception('Unsupported Expression type: ${expression.runtimeType}.');
  }

  Interpretable planIdent(IdentExpr ident) {
    return AttributeValueInterpretable(
        attributeFactory.maybeAttribute(ident.name), adapter);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L239
  Interpretable planCall(CallExpr expression) {
    final functionName = expression.function;
    // Skip target, p.resolveFunction.
    final interpretableArguments = [
      // If there is a target, it becomes the first argument.
      if (expression.target != null) plan(expression.target!),
      ...expression.args.map((e) => plan(e))
    ];
    if (functionName == Operators.logicalAnd.name) {
      return planCallLogicalAnd(expression, interpretableArguments);
    }
    if (functionName == Operators.logicalOr.name) {
      return planCallLogicalOr(expression, interpretableArguments);
    }
    if (functionName == Operators.conditional.name) {
      return planCallConditional(interpretableArguments);
    }
    if (functionName == Operators.equals.name) {
      return planCallEqual(expression, interpretableArguments);
    }
    if (functionName == Operators.notEquals.name) {
      return planCallNotEqual(expression, interpretableArguments);
    }
    // TODO: implement indexer, optSelect, optIndex.

    final functionImplementation = dispatcher.findOverload(functionName);
    switch (interpretableArguments.length) {
      // TODO: handle zero functions.
      case 1:
        return planCallUnary(expression, functionName, functionImplementation!,
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
        attributeFactory.relativeAttribute(eval), adapter);
  }

  Interpretable planCallBinary(CallExpr expression, String functionName,
      Overload? functionImplementation, List<Interpretable> arguments) {
    return BinaryInterpretable(functionName,
        functionImplementation?.binaryOperator, arguments[0], arguments[1]);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L516
  Interpretable planCreateList(ListExpr expression) {
    final elements = expression.elements.map((e) => plan(e)).toList();
    return ListInterpretable(elements, adapter);
  }

  Interpretable planCallUnary(CallExpr expression, String functionName,
      Overload functionImplementation, List<Interpretable> arguments) {
    return UnaryInterpretable(
        functionImplementation.unaryOperator!, arguments[0]);
  }

  // In cel-go, it's called a Struct, but that's how it is called in the
  // Protobuf. In CEL, it's called a Map. So we use Map.
  // https://github.com/google/cel-spec/blob/master/doc/langdef.md#dynamic-values
  // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L682
  Interpretable planCreateMap(MapExpr expression) {
    final keys = expression.entries.map((e) => plan(e.key)).toList();
    final values = expression.entries.map((e) => plan(e.value)).toList();
    return MapInterpretable(keys, values, adapter);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L453
  Interpretable planCallConditional(List<Interpretable> arguments) {
    return AttributeValueInterpretable(
        ConditionalAttribute(
            condition: arguments[0], truthy: arguments[1], falsy: arguments[2]),
        adapter);
  }

  Interpretable planConst(ConstExpression constant) {
    // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/planner.go#L644
    final constantValue = adapter.nativeToValue(constant.value);
    return InterpretableConst(constantValue);
  }
}
