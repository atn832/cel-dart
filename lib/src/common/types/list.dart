import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/traits.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/list.go

final listType = Type_("list", {
  Traits.AdderType,
  Traits.ContainerType,
  Traits.IndexerType,
  Traits.IterableType,
  Traits.SizerType
});

class ListValue extends Value {
  ListValue(this.value, this.typeAdapter);

  TypeAdapter typeAdapter;

  @override
  final List value;

  @override
  Type_ get type => listType;
}
