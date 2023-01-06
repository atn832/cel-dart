import 'package:cel/src/common/types/ref/value.dart';

final intType = Type_('int');

class IntValue implements Value {
  IntValue(this.value);

  @override
  Type_ get type => intType;

  @override
  final int value;
}
