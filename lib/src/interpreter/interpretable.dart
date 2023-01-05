import 'activation.dart';

class Interpretable {
  dynamic evaluate(Activation activation) {}
}

class InterpretableConst implements Interpretable {
  InterpretableConst(this.value);

  final dynamic value;

  @override
  evaluate(Activation activation) {
    return value;
  }
}
