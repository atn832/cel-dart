import '../overloads/overloads.dart';
import 'ref/value.dart';
import 'traits/receiver.dart';

class StringValue implements Value, Receiver {
  StringValue(this.value);

  @override
  receive(String function, String overload, List<dynamic> arguments) {
    return stringOneArgOverloads[function]!(value, arguments);
  }

  @override
  final String value;
}

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go
// class String_ extends String implements Receiver {
// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go#L47
final stringOneArgOverloads = <String, dynamic Function(String, dynamic)>{
  // overloads.Contains: stringContains,
  // overloads.EndsWith: stringEndsWith,
  Overloads.startsWith.name: stringStartsWith,
};

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/string.go#L217
stringStartsWith(String s, dynamic value) {
  return s.startsWith(value);
}
