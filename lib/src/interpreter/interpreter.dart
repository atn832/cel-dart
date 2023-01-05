import 'package:cel/src/interpreter/attribute_factory.dart';

import '../cel/checked_expression.dart';
import 'interpretable.dart';
import 'planner.dart';

class Interpreter {
  Interpreter({required this.attributeFactory});

  final AttributeFactory attributeFactory;

  Interpretable interpet(CheckedExpression checkedExpression) {
    final p = Planner(attributeFactory: attributeFactory);
    return p.plan(checkedExpression.expression);
  }
}
