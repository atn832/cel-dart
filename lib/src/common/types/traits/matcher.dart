// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/traits/matcher.go

import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/ref/value.dart';

/// Matcher interface for supporting 'matches()' overloads.
abstract class Matcher {
  /// Match returns true if the pattern matches the current value.
  BooleanValue match(Value pattern);
}
