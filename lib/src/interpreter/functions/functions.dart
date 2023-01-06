// https://github.com/google/cel-go/blob/master/interpreter/functions/functions.go

class Overload {
  Overload(this.name, {this.unaryOperator, this.binaryOperator});

  final String name;
  UnaryOperator? unaryOperator;
  BinaryOperator? binaryOperator;
}

typedef UnaryOperator = dynamic Function(dynamic value);

typedef BinaryOperator = dynamic Function(
    dynamic leftHandSide, dynamic rightHandSide);
