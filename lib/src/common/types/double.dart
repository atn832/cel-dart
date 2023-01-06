import 'package:cel/src/common/types/ref/value.dart';
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

class DoubleValue implements Value {
  DoubleValue(this.value);

  @override
  Type_ get type => doubleType;

  @override
  final double value;
}
