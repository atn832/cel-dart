import 'package:cel/src/common/types/ref/provider.dart';

import '../cel/checked_expression.dart';
import 'attribute_factory.dart';
import 'dispatcher.dart';
import 'functions/standard.dart';
import 'interpretable.dart';
import 'planner.dart';

class Interpreter {
  Interpreter(
      {required this.attributeFactory,
      required this.dispatcher,
      required this.adapter});

  /// NewStandardInterpreter builds a Dispatcher and TypeProvider with support for all of the CEL
  /// builtins defined in the language definition.
  /// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/interpreter/interpreter.go#L179
  factory Interpreter.standard(
      {required AttributeFactory attributeFactory,
      required TypeAdapter adapter}) {
    return Interpreter(
        attributeFactory: attributeFactory,
        adapter: adapter,
        dispatcher: Dispatcher(standardOverloads()));
  }

  final AttributeFactory attributeFactory;
  final Dispatcher dispatcher;
  final TypeAdapter adapter;

  Interpretable interpet(CheckedExpression checkedExpression) {
    final p = Planner(
        attributeFactory: attributeFactory,
        dispatcher: dispatcher,
        adapter: adapter);
    return p.plan(checkedExpression.expression);
  }
}
