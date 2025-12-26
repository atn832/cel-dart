import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/int.dart';
import 'package:cel/src/common/types/traits/comparer.dart';
import 'package:cel/src/common/types/traits/matcher.dart';
import 'package:cel/src/common/types/traits/math.dart';
import 'package:cel/src/common/types/traits/traits.dart';

import '../overloads/overloads.dart';
import 'ref/value.dart';
import 'traits/receiver.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go

final stringType = ValueType('string', {
  Traits.adderType,
  Traits.comparerType,
  Traits.matcherType,
  Traits.receiverType,
  Traits.sizerType
});

class StringValue extends Value implements Receiver, Matcher, Adder, Comparer {
  StringValue(this.value);

  @override
  receive(String function, String overload, List<Value> arguments) {
    return stringOneArgOverloads[function]!(value, arguments.first);
  }

  @override
  final String value;

  @override
  ValueType get type => stringType;

  @override
  BooleanValue match(Value pattern) {
    return BooleanValue(RegExp(pattern.value).hasMatch(value));
  }

  @override
  add(Value other) {
    return StringValue(value + other.value);
  }

  @override
  Value compare(Value other) {
    return IntValue(value.compareTo(other.value));
  }
}

// class String_ extends String implements Receiver {
// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go#L47
final stringOneArgOverloads = <String, Value Function(String, Value)>{
  Overloads.contains.name: stringContains,
  Overloads.endsWith.name: stringEndsWith,
  Overloads.startsWith.name: stringStartsWith,
};

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go#L217
Value stringStartsWith(String s, Value value) {
  return BooleanValue(s.startsWith(value.value));
}

Value stringEndsWith(String s, Value value) {
  return BooleanValue(s.endsWith(value.value));
}

Value stringContains(String s, Value value) {
  return BooleanValue(s.contains(value.value));
}
