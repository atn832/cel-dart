import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/ref/provider.dart';
import 'package:cel/src/common/types/ref/value.dart';
import 'package:cel/src/common/types/traits/container.dart';
import 'package:cel/src/common/types/traits/indexer.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/traits/traits.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/list.go

final listType = ValueType("list", {
  Traits.adderType,
  Traits.containerType,
  Traits.indexerType,
  Traits.iterableType,
  Traits.sizerType
});

class ListValue extends Value implements Indexer, Container, Adder {
  ListValue(this.value, this.typeAdapter);

  final TypeAdapter typeAdapter;

  @override
  final List<Value> value;

  @override
  ValueType get type => listType;

  @override
  Value get(Value index) {
    return value[index.value];
  }

  @override
  convertToNative() {
    return value.map((e) => e.convertToNative()).toList();
  }

  @override
  BooleanValue contains(Value value) {
    return BooleanValue(this.value.contains(value));
  }

  @override
  add(Value other) {
    return ListValue([...value, ...other.value], typeAdapter);
  }
}
