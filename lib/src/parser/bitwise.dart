import 'dart:math';

/// Reimplements `&` to work on Web for values over 32 bits. This is a
/// workaround for how Dart Web uses only 32 bit values. See https://dart.dev/guides/language/numbers#bitwise-operations:
/// "For performance reasons on the web, bitwise (&, |, ^, ~) and shift (<<,>>,
/// >>>) operators on int use the native JavaScript equivalents. In JavaScript,
/// the operands are truncated to 32-bit integers that are treated as unsigned.
/// This treatment can lead to surprising results on larger numbers. In
/// particular, if operands are negative or don’t fit into 32 bits, they’re
/// likely to produce different results between native and web."
num bitwiseAnd(num n1, num n2) {
  return (n1 ~/ pow(2, 32) & n2 ~/ pow(2, 32)) * pow(2, 32) +
      ((n1 % pow(2, 32)).toInt() & (n2 % pow(2, 32)).toInt());
}
