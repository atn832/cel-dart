import 'package:cel/src/common/types/ref/provider.dart';

import '../cel/checked_expression.dart';
import 'attribute_factory.dart';
import 'dispatcher.dart';
import 'interpretable.dart';
import 'planner.dart';

class Interpreter {
  Interpreter(
      {required this.attributeFactory,
      required this.dispatcher,
      required this.adapter});

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
