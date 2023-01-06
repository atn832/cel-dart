import 'activation.dart';
import 'attribute.dart';
import 'functions/functions.dart';

abstract class Interpretable {
  dynamic evaluate(Activation activation);
}

class InterpretableConst implements Interpretable {
  InterpretableConst(this.value);

  final dynamic value;

  @override
  evaluate(Activation activation) {
    return value;
  }
}

// Port of https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/interpretable.go#L1219.
class AttributeValueInterpretable implements Interpretable {
  AttributeValueInterpretable(this.attribute);

  final Attribute attribute;

  @override
  evaluate(Activation activation) {
    return attribute.resolve(activation);
  }

  void addQualifier(Qualifier qualifier) {
    attribute.addQualifier(qualifier);
  }
}

class EqualInterpretable implements Interpretable {
  EqualInterpretable(this.leftHandSide, this.rightHandSide);

  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  @override
  evaluate(Activation activation) {
    return leftHandSide.evaluate(activation) ==
        rightHandSide.evaluate(activation);
  }
}

class NotEqualInterpretable implements Interpretable {
  NotEqualInterpretable(this.leftHandSide, this.rightHandSide);

  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  @override
  evaluate(Activation activation) {
    return leftHandSide.evaluate(activation) !=
        rightHandSide.evaluate(activation);
  }
}

class LogicalAndInterpretable implements Interpretable {
  LogicalAndInterpretable(this.leftHandSide, this.rightHandSide);

  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  @override
  evaluate(Activation activation) {
    return leftHandSide.evaluate(activation) &&
        rightHandSide.evaluate(activation);
  }
}

class LogicalOrInterpretable implements Interpretable {
  LogicalOrInterpretable(this.leftHandSide, this.rightHandSide);

  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  @override
  evaluate(Activation activation) {
    return leftHandSide.evaluate(activation) ||
        rightHandSide.evaluate(activation);
  }
}

class UnaryInterpretable implements Interpretable {
  UnaryInterpretable(this.unaryOperator, this.value);

  final UnaryOperator unaryOperator;
  final Interpretable value;

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/interpretable.go#L439
  @override
  evaluate(Activation activation) {
    // Skipped porting Traits.
    return unaryOperator(value.evaluate(activation));
  }
}

class BinaryInterpretable implements Interpretable {
  BinaryInterpretable(
      this.binaryOperator, this.leftHandSide, this.rightHandSide);

  final BinaryOperator binaryOperator;
  final Interpretable leftHandSide;
  final Interpretable rightHandSide;

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/interpretable.go#L499
  @override
  evaluate(Activation activation) {
    final leftValue = leftHandSide.evaluate(activation);
    final rightValue = rightHandSide.evaluate(activation);
    // Skipped porting ReceiverType.
    return binaryOperator(leftValue, rightValue);
  }
}

class ListInterpretable implements Interpretable {
  ListInterpretable(this.elements);

  final List<Interpretable> elements;

  @override
  evaluate(Activation activation) {
    return elements.map((e) => e.evaluate(activation)).toList();
  }
}
