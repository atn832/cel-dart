import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/traits.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/map.go

final mapType = Type_("map", {
  Traits.ContainerType,
  Traits.IndexerType,
  Traits.IterableType,
  Traits.SizerType
});

class MapValue extends Value {
  MapValue(this.value, this.typeAdapter);

  TypeAdapter typeAdapter;

  @override
  final Map value;

  @override
  Type_ get type => mapType;
}
