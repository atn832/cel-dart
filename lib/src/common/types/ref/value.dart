// https://github.com/google/cel-go/blob/master/common/types/ref/reference.go
import 'package:equatable/equatable.dart';

import '../traits/traits.dart';

// Intentionally avoiding conflict with Dart's Type.
class ValueType {
  ValueType(this.name, [this.traits = const {}]);

  final String name;
  final Set<Traits> traits;

  bool hasTrait(Traits trait) => traits.contains(trait);
}

abstract class Value extends Equatable {
  ValueType get type;
  dynamic get value;

  // Works for all primitive types. Only List and Map need to re-implement it.
  dynamic convertToNative() {
    return value;
  }

  @override
  List<Object?> get props => [convertToNative()];
}
