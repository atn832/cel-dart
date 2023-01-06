import 'package:cel/src/common/types/ref/value.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/null.go

// NullType singleton.
final nullType = Type_("null_type");
// NullValue singleton.
final nullValue = NullValue();

class NullValue implements Value {
  @override
  Type_ get type => nullType;

  @override
  get value => null;
}
