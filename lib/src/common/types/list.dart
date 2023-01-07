import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/indexer.dart';
import 'package:cel/src/common/types/traits/traits.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/list.go

final listType = Type_("list", {
  Traits.AdderType,
  Traits.ContainerType,
  Traits.IndexerType,
  Traits.IterableType,
  Traits.SizerType
});

class ListValue extends Value implements Indexer {
  ListValue(this.value, this.typeAdapter);

  final TypeAdapter typeAdapter;

  @override
  final List<Value> value;

  @override
  Type_ get type => listType;

  @override
  Value get(Value index) {
    return value[index.value];
  }

  @override
  convertToNative() {
    return value.map((e) => e.convertToNative()).toList();
  }
}
