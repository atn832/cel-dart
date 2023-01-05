// https://github.com/google/cel-go/blob/master/interpreter/functions/functions.go

class Overload {
  Overload(this.name, {this.binaryOperator});

  final String name;
  BinaryOperator? binaryOperator;
}

typedef BinaryOperator = dynamic Function(
    dynamic leftHandSide, dynamic rightHandSide);
