import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/traits.dart';

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
