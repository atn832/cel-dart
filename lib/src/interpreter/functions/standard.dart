import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/matcher.dart';
import 'package:cel/src/common/types/traits/math.dart';

import '../../common/overloads/overloads.dart';
import '../../operators/operators.dart';
import 'functions.dart';

// https://github.com/google/cel-go/blob/master/interpreter/functions/standard.go
List<Overload> standardOverloads() {
  return [
    // Logical not (!a)
    Overload(
      Operators.logicalNot.name,
      unaryOperator: (value) {
        if (value is! Negater) {
          throw StateError('$value should be a Negater');
        }
        return value.negate();
      },
    ),

    // Less than operator
    Overload(Operators.less.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Comparer) {
        throw StateError('$leftHandSide should be a Comparer');
      }
      return BooleanValue(leftHandSide.compare(rightHandSide).value < 0);
    }),

    // Less than or equal operator
    Overload(Operators.lessEquals.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Comparer) {
        throw StateError('$leftHandSide should be a Comparer');
      }
      return BooleanValue(leftHandSide.compare(rightHandSide).value <= 0);
    }),

    // Greater than operator
    Overload(Operators.greater.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Comparer) {
        throw StateError('$leftHandSide should be a Comparer');
      }
      return BooleanValue(leftHandSide.compare(rightHandSide).value > 0);
    }),

    // Greater than equal operators
    Overload(Operators.greaterEquals.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Comparer) {
        throw StateError('$leftHandSide should be a Comparer');
      }
      return BooleanValue(leftHandSide.compare(rightHandSide).value >= 0);
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
      return object is List
          ? object.contains(element)
          : object is Map
              ? object.containsKey(element)
              : throw StateError('in works only on lists and maps');
    }),

    // Matches function
    Overload(Overloads.matches.name, binaryOperator: (string, regExp) {
      if (string is! Matcher) {
        throw StateError('The first parameter should be a Matcher');
      }
      return string.match(regExp);
    }),
  ];
}
