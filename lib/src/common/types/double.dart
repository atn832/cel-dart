import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/traits/traits.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/double.go

final doubleType = ValueType('double', {
  Traits.adderType,
  Traits.comparerType,
  Traits.dividerType,
  Traits.multiplierType,
  Traits.negatorType,
  Traits.subtractorType
});

class DoubleValue extends Value
    implements Comparer, Adder, Divider, Multiplier, Subtractor, Modder {
  DoubleValue(this.value);

  @override
  ValueType get type => doubleType;

  @override
  final double value;

  // https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/double.go#L61
  @override
  Value compare(Value other) {
    // Not as exhaustive as cel-go regarding very large or very small numbers.
    return IntValue(value.compareTo(other.value));
  }

  @override
  add(Value other) {
    return DoubleValue(value + other.value);
  }

  @override
  divide(Value denominator) {
    return DoubleValue(value / denominator.value);
  }

  @override
  modulo(Value denominator) {
    return DoubleValue(value % denominator.value);
  }

  @override
  multiply(Value other) {
    return DoubleValue(value * other.value);
  }

  @override
  subtract(Value subtrahend) {
    return DoubleValue(value - subtrahend.value);
  }
}
