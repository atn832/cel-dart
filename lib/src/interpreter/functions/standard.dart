import '../../operators/operators.dart';
import 'functions.dart';

// https://github.com/google/cel-go/blob/master/interpreter/functions/standard.go
List<Overload> standardOverloads() {
  return [
    // Logical not (!a)
    Overload(
      Operators.logicalNot.name,
      unaryOperator: (value) => !value,
    ),

    // Less than operator
    Overload(Operators.less.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Comparable) {
        throw StateError('$leftHandSide should be a Comparable');
      }
      return leftHandSide.compareTo(rightHandSide) < 0;
    }),

    // Less than or equal operator
    Overload(Operators.lessEquals.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Comparable) {
        throw StateError('$leftHandSide should be a Comparable');
      }
      return leftHandSide.compareTo(rightHandSide) <= 0;
    }),

    // Greater than operator
    Overload(Operators.greater.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Comparable) {
        throw StateError('$leftHandSide should be a Comparable');
      }
      return leftHandSide.compareTo(rightHandSide) > 0;
    }),

    // Greater than equal operators
    Overload(Operators.greaterEquals.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Comparable) {
        throw StateError('$leftHandSide should be a Comparable');
      }
      return leftHandSide.compareTo(rightHandSide) >= 0;
    }),

    // Add operator
    Overload(Operators.add.name, binaryOperator: (leftHandSide, rightHandSide) {
      return leftHandSide + rightHandSide;
    }),

    // Subtract operators
    Overload(Operators.subtract.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return leftHandSide - rightHandSide;
    }),

    // Multiply operator
    Overload(Operators.multiply.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return leftHandSide * rightHandSide;
    }),

    // Divide operator
    Overload(Operators.divide.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return leftHandSide / rightHandSide;
    }),

    // Modulo operator
    Overload(Operators.modulo.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      return leftHandSide % rightHandSide;
    }),

    // TODO: implement Negate.

    // Index operator
    Overload(Operators.index_.name, binaryOperator: (target, index) {
      return target[index];
    }),

    // TODO: implement size.

    // In operator
    Overload(Operators.in_.name, binaryOperator: (element, object) {
      return object.contains(element);
    }),

    // TODO: implement matches.
  ];
}
