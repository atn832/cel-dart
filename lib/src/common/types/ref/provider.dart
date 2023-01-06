import 'value.dart';

/// TypeAdapter converts native Go values of varying type and complexity to equivalent CEL values.
/// https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/common/types/ref/provider.go#L54
abstract class TypeAdapter {
  // NativeToValue converts the input `value` to a CEL `ref.Val`.
  // ignore: non_constant_identifier_names
  Value nativeToValue(dynamic value);
}
