import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/math.dart';

final intType = ValueType('int');

class IntValue extends Value
    implements Comparer, Adder, Divider, Multiplier, Subtractor, Modder {
  IntValue(this.value);

  @override
  ValueType get type => intType;

  @override
  final int value;

  // https://github.com/google/cel-go/blob/92fda7d38a37f42d4154147896cfd4ebbf8f846e/common/types/int.go#L75
  @override
  Value compare(Value other) {
    // Not as exhaustive as cel-go regarding very large or very small numbers.
    return IntValue(value.compareTo(other.value));
  }

  @override
  add(Value other) {
    return IntValue((value + other.value).toInt());
  }

  @override
  divide(Value denominator) {
    return IntValue(value ~/ denominator.value);
  }

  @override
  modulo(Value denominator) {
    return IntValue((value % denominator.value).toInt());
  }

  @override
  multiply(Value other) {
    return IntValue((value * other.value).toInt());
  }

  @override
  subtract(Value subtrahend) {
    return IntValue((value - subtrahend.value).toInt());
  }
}
