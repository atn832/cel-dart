import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/null.dart';
import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/string.dart';

// cel-go description:
// NewRegistry accepts a list of proto message instances and returns a type
// provider which can create new instances of the provided message or any
// message that proto depends upon in its FileDescriptor.
/// Provides an adapter to the default types only.
TypeAdapter newRegistry() {
  return TypeRegistry()
    ..registerTypes([
      boolType,
      // bytesType,
      // doubleType,
      // DurationType,
      intType,
      // listType,
      // mapType,
      nullType,
      stringType
    ]);
  // TimestampType,
  // TypeType,
  // UintType);
}

class TypeRegistry implements TypeAdapter {
  registerTypes(List<Type_> types) {}

  @override
  Value nativeToValue(value) {
    return _nativeToValue(this, value);
  }
}

// https://github.com/google/cel-go/blob/051835c9903525b656a438f778510d9b619b3702/common/types/provider.go#L262
_nativeToValue(TypeAdapter adapter, dynamic value) {
  if (value == null) {
    return nullValue;
  }
  if (value is bool) {
    return BooleanValue(value);
  }
  if (value is int) {
    return IntValue(value);
  }
  if (value is String) {
    return StringValue(value);
  }
  throw UnimplementedError('Unsupported type for $value: ${value.runtimeType}');
}
