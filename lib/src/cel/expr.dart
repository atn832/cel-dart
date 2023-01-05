import 'package:equatable/equatable.dart';

class Expr {}

// Based on https://github.com/googleapis/googleapis/blob/870a5ed7e141b4faf70e2a0858854e9b5bb18612/google/api/expr/v1beta1/expr.proto#L89-L99.
class CallExpr extends Equatable implements Expr {
  CallExpr({required this.function, this.target, required this.args});

  final String function;
  final Expr? target;
  final List<Expr> args;

  @override
  List<Object?> get props => [function, target, args];

  @override
  bool? get stringify => true;
}

class SelectExpr extends Equatable implements Expr {
  SelectExpr({required this.operand, required this.field});

  final Expr operand;
  final String field;

  @override
  List<Object?> get props => [operand, field];

  @override
  bool? get stringify => true;
}

class StringLiteralExpr extends Equatable implements ConstExpression {
  StringLiteralExpr(this.value);

  @override
  final String value;

  @override
  List<Object?> get props => [value];

  @override
  bool? get stringify => true;
}

class IntLiteralExpr extends Equatable implements ConstExpression {
  IntLiteralExpr(this.value);

  @override
  final int value;

  @override
  List<Object?> get props => [value];

  @override
  bool? get stringify => true;
}

abstract class ConstExpression extends Expr {
  dynamic get value;
}

class BoolLiteralExpr extends Equatable implements ConstExpression {
  BoolLiteralExpr(this.value);

  @override
  final bool value;

  @override
  List<Object?> get props => [value];

  @override
  bool? get stringify => true;
}

class NullLiteralExpr extends Equatable implements ConstExpression {
  @override
  get value => null;

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class IdentExpr extends Equatable implements Expr {
  IdentExpr(this.name);

  final String name;

  @override
  List<Object?> get props => [name];

  @override
  bool? get stringify => true;
}
