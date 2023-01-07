//https://github.com/google/cel-go/blob/92fda7d38a37f42d4154147896cfd4ebbf8f846e/common/types/traits/container.go#L20

import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/ref/value.dart';

/// Container interface which permits containment tests such as 'a in b'.
abstract class Container {
  /// Contains returns true if the value exists within the object.
  BooleanValue contains(Value value);
}
