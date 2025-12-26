import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/container.dart';
import 'package:cel/src/common/types/traits/indexer.dart';
import 'package:cel/src/common/types/traits/traits.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/map.go

final mapType = ValueType("map", {
  Traits.containerType,
  Traits.indexerType,
  Traits.iterableType,
  Traits.sizerType
});

class MapValue extends Value implements Indexer, Container {
  MapValue(this.value, this.typeAdapter);

  factory MapValue.fromNativeKeyValues(
      Map<dynamic, dynamic> map, TypeAdapter typeAdapter) {
    // Skipped the MapAccessor and Mapper code.
    // https://github.com/google/cel-go/blob/051835c9903525b656a438f778510d9b619b3702/common/types/map.go#L80
    return MapValue(
        Map.fromEntries(map.entries.map((e) => MapEntry(
            typeAdapter.nativeToValue(e.key),
            typeAdapter.nativeToValue(e.value)))),
        typeAdapter);
  }

  final TypeAdapter typeAdapter;

  @override
  final Map<Value, Value> value;

  @override
  ValueType get type => mapType;

  @override
  Value get(Value index) {
    // Simplified compared to https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/map.go#L272.
    return typeAdapter.nativeToValue(value[index]);
  }

  @override
  convertToNative() {
    return Map.fromEntries(value.entries
        .map((entry) => MapEntry(
            entry.key.convertToNative(), entry.value.convertToNative()))
        .toList());
  }

  @override
  BooleanValue contains(Value value) {
    return BooleanValue(this.value.containsKey(value));
  }
}
