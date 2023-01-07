import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/comparer.dart';

final intType = Type_('int');

class IntValue implements Value, Comparer {
  IntValue(this.value);

  @override
  Type_ get type => intType;

  @override
  final int value;

  // https://github.com/google/cel-go/blob/92fda7d38a37f42d4154147896cfd4ebbf8f846e/common/types/int.go#L75
  @override
  Value compare(Value other) {
    // Not as exhaustive as cel-go regarding very large or very small numbers.
    return IntValue(value.compareTo(other.value));
  }
}
