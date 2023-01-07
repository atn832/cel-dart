import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/container.dart';
import 'package:cel/src/common/types/traits/indexer.dart';
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
      if (leftHandSide is! Adder) {
        throw StateError('$leftHandSide should be an Adder');
      }
      return leftHandSide.add(rightHandSide);
    }),

    // Subtract operators
    Overload(Operators.subtract.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Subtractor) {
        throw StateError('$leftHandSide should be an Subtractor');
      }
      return leftHandSide.subtract(rightHandSide);
    }),

    // Multiply operator
    Overload(Operators.multiply.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Multiplier) {
        throw StateError('$leftHandSide should be an Multiplier');
      }
      return leftHandSide.multiply(rightHandSide);
    }),

    // Divide operator
    Overload(Operators.divide.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Divider) {
        throw StateError('$leftHandSide should be an Divider');
      }
      return leftHandSide.divide(rightHandSide);
    }),

    // Modulo operator
    Overload(Operators.modulo.name,
        binaryOperator: (leftHandSide, rightHandSide) {
      if (leftHandSide is! Modder) {
        throw StateError('$leftHandSide should be an Modder');
      }
      return leftHandSide.modulo(rightHandSide);
    }),

    // TODO: implement Negate.

    // Index operator
    // https://github.com/google/cel-go/blob/92fda7d38a37f42d4154147896cfd4ebbf8f846e/interpreter/functions/standard.go#L149
    Overload(Operators.index_.name, binaryOperator: (target, index) {
      if (target is! Indexer) {
        throw StateError('$target should be an Indexer');
      }
      return target.get(index);
    }),

    // TODO: implement size.

    // In operator
    // https://github.com/google/cel-go/blob/92fda7d38a37f42d4154147896cfd4ebbf8f846e/interpreter/functions/standard.go#L163
    Overload(Operators.in_.name, binaryOperator: (element, object) {
      if (object is! Container) {
        throw StateError('$object should be a Container');
      }
      return object.contains(element);
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
