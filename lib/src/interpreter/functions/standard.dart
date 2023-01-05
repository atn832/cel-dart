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
  ];
}
