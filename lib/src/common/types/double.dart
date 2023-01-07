import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/traits.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/double.go

final doubleType = Type_('double', {
  Traits.AdderType,
  Traits.ComparerType,
  Traits.DividerType,
  Traits.MultiplierType,
  Traits.NegatorType,
  Traits.SubtractorType
});

class DoubleValue implements Value, Comparer {
  DoubleValue(this.value);

  @override
  Type_ get type => doubleType;

  @override
  final double value;

  // https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/double.go#L61
  @override
  Value compare(Value other) {
    // Not as exhaustive as cel-go regarding very large or very small numbers.
    return IntValue(value.compareTo(other.value));
  }
}
