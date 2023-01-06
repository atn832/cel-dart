// https://github.com/google/cel-go/blob/master/common/types/ref/reference.go
import '../traits/traits.dart';

// Intentionally avoiding conflict with Dart's Type.
class Type_ {
  Type_(this.name, [this.traits = const {}]);

  final String name;
  final Set<Traits> traits;

  bool hasTrait(Traits trait) => traits.contains(trait);
}

abstract class Value {
  Type_ get type;
  dynamic get value;
}
