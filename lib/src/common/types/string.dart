import 'package:cel/src/common/types/bool.dart';
import 'package:cel/src/common/types/traits/matcher.dart';
import 'package:cel/src/common/types/traits/traits.dart';

import '../overloads/overloads.dart';
import 'ref/value.dart';
import 'traits/receiver.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go

final stringType = Type_('string', {
  Traits.AdderType,
  Traits.ComparerType,
  Traits.MatcherType,
  Traits.ReceiverType,
  Traits.SizerType
});

class StringValue extends Value implements Receiver, Matcher {
  StringValue(this.value);

  @override
  receive(String function, String overload, List<Value> arguments) {
    return stringOneArgOverloads[function]!(value, arguments.first);
  }

  @override
  final String value;

  @override
  Type_ get type => stringType;

  @override
  BooleanValue match(Value pattern) {
    return BooleanValue(RegExp(pattern.value).hasMatch(value));
  }
}

// class String_ extends String implements Receiver {
// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go#L47
final stringOneArgOverloads = <String, Value Function(String, Value)>{
  // overloads.Contains: stringContains,
  // overloads.EndsWith: stringEndsWith,
  Overloads.startsWith.name: stringStartsWith,
};

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go#L217
Value stringStartsWith(String s, Value value) {
  return BooleanValue(s.startsWith(value.value));
}
