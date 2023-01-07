// https://github.com/google/cel-go/blob/92fda7d38a37f42d4154147896cfd4ebbf8f846e/common/types/traits/comparer.go#L23

import 'package:cel/src/common/types/ref/value.dart';

/// Comparer interface for ordering comparisons between values in order to
/// support '<', '<=', '>=', '>' overloads.
abstract class Comparer {
  /// Compare this value to the input other value, returning an Int:
  ///
  ///    this < other  -> Int(-1)
  ///    this == other ->  Int(0)
  ///    this > other  ->  Int(1)
  ///
  /// If the comparison cannot be made or is not supported, an error should
  /// be returned.
  Value compare(Value other);
}
