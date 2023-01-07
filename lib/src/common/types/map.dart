import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/container.dart';
import 'package:cel/src/common/types/traits/indexer.dart';
import 'package:cel/src/common/types/traits/traits.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/map.go

final mapType = Type_("map", {
  Traits.ContainerType,
  Traits.IndexerType,
  Traits.IterableType,
  Traits.SizerType
});

class MapValue extends Value implements Indexer, Container {
  MapValue(this.value, this.typeAdapter);

  final TypeAdapter typeAdapter;

  @override
  final Map<Value, Value> value;

  @override
  Type_ get type => mapType;

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
