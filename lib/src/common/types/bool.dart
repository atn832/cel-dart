// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/bool.go
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/traits/traits.dart';

import 'ref/value.dart';

final boolType = Type_('bool', {Traits.ComparerType, Traits.NegatorType});

class BooleanValue extends Value implements Negater, Comparer {
  BooleanValue(this.value);

  @override
  final bool value;

  @override
  Type_ get type => boolType;

  @override
  Value negate() {
    return BooleanValue(!value);
  }

  @override
  Value compare(Value other) {
    return IntValue(value == other.value
        ? 0
        : !value && other.value
            ? -1
            : 1);
  }
}
