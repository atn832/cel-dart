// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/bool.go
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/traits/traits.dart';

import 'ref/value.dart';

final boolType = Type_('bool', {Traits.ComparerType, Traits.NegatorType});

class BooleanValue extends Value implements Negater {
  BooleanValue(this.value);

  @override
  final bool value;

  @override
  Type_ get type => boolType;

  @override
  Value negate() {
    return BooleanValue(!value);
  }
}
