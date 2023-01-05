import '../../operators/operators.dart';
import 'functions.dart';

List<Overload> standardOverloads() {
  return [
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
  ];
}
