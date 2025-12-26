import 'package:cel/src/common/types/list.dart';
import 'package:cel/src/common/types/map.dart';
import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/double.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/null_.dart';
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
  registerTypes(List<ValueType> types) {}

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
  // Pass-through all Value types.
  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/common/types/provider.go#L266-L289
  if (value is BooleanValue) {
    return value;
  }
  if (value is IntValue) {
    return value;
  }
  if (value is DoubleValue) {
    return value;
  }
  if (value is StringValue) {
    return value;
  }
  if (value is MapValue) {
    return value;
  }
  // Wrap primitives.
  if (value is bool) {
    return BooleanValue(value);
  }
  if (value is int) {
    return IntValue(value);
  }
  if (value is double) {
    return DoubleValue(value);
  }
  if (value is String) {
    return StringValue(value);
  }
  // https://github.com/google/cel-go/blob/051835c9903525b656a438f778510d9b619b3702/common/types/provider.go#L370
  if (value is Map<Value, Value>) {
    return MapValue(value, adapter);
  }
  // https://github.com/google/cel-go/blob/051835c9903525b656a438f778510d9b619b3702/common/types/provider.go#L366-L369
  if (value is Map) {
    return MapValue.fromNativeKeyValues(value, adapter);
  }
  // https://github.com/google/cel-go/blob/051835c9903525b656a438f778510d9b619b3702/common/types/provider.go#L361-L362
  if (value is List<String>) {
    return ListValue(value.map((e) => StringValue(e)).toList(), adapter);
  }
  // https://github.com/google/cel-go/blob/051835c9903525b656a438f778510d9b619b3702/common/types/provider.go#L363-L364
  if (value is List<Value>) {
    return ListValue(value, adapter);
  }
  throw UnimplementedError('Unsupported type for $value: ${value.runtimeType}');
}
