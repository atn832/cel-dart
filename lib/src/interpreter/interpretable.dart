import 'activation.dart';
import 'attribute.dart';

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
