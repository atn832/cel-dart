/// https://github.com/google/cel-go/blob/7d206a43b28ca86004ae0791cf874c9da7f2c44d/common/types/traits/math.go

import 'package:cel/src/common/types/ref/value.dart';

/// Adder interface to support '+' operator overloads.
abstract class Adder {
  /// Add returns a combination of the current value and other value.
  //
  /// If the other value is an unsupported type, an error is returned.
  add(Value other);
}

/// Divider interface to support '/' operator overloads.
abstract class Divider {
  /// Divide returns the result of dividing the current value by the input
  /// denominator.
  //
  /// A denominator value of zero results in an error.
  divide(Value denominator);
}

/// Modder interface to support '%' operator overloads.
abstract class Modder {
  /// Modulo returns the result of taking the modulus of the current value
  /// by the denominator.
  //
  /// A denominator value of zero results in an error.
  modulo(Value denominator);
}

/// Multiplier interface to support '*' operator overloads.
abstract class Multiplier {
  /// Multiply returns the result of multiplying the current and input value.
  multiply(Value other);
}

//// Negater interface to support unary '-' and '!' operator overloads.
abstract class Negater {
  //// Negate returns the complement of the current value.
  Value negate();
}

/// Subtractor interface to support binary '-' operator overloads.
abstract class Subtractor {
  /// Subtract returns the result of subtracting the input from the current
  /// value.
  subtract(Value subtrahend);
}
