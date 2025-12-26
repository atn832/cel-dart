// This file is called null_.dart to prevent conflicts in Flutter Web
//(Debug mode). See https://github.com/atn832/fake_firebase_security_rules/issues/1#issuecomment-1439661678.
import 'package:cel/src/common/types/ref/value.dart';

// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/null.go

// NullType singleton.
final nullType = ValueType("null_type");
// NullValue singleton.
final nullValue = NullValue();

class NullValue extends Value {
  @override
  ValueType get type => nullType;

  @override
  get value => null;
}
