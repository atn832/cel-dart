import 'package:equatable/equatable.dart';

class Expr {}

// Based on https://github.com/googleapis/googleapis/blob/870a5ed7e141b4faf70e2a0858854e9b5bb18612/google/api/expr/v1beta1/expr.proto#L89-L99.
class CallExpr extends Expr {
  late final String function;
  late final Expr target;
  late final List<dynamic> args;
}

class SelectExpr extends Expr {
  late final Expr operand;
  late final String field;
}

class StringLiteralExpr extends Equatable implements Expr {
  late final String value;

  @override
  List<Object?> get props => [value];

  @override
  bool? get stringify => true;
}

class IdentExpr extends Expr {
  late final String name;
}
