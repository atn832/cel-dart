// https://github.com/google/cel-go/blob/7d206a43b28ca86004ae0791cf874c9da7f2c44d/common/types/traits/math.go

import 'package:cel/src/common/types/ref/value.dart';

/// Negater interface to support unary '-' and '!' operator overloads.
abstract class Negater {
  /// Negate returns the complement of the current value.
  Value negate();
}
