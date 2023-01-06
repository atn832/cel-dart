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

class DoubleLiteralExpr extends Equatable implements ConstExpression {
  DoubleLiteralExpr(this.value);

  @override
  final double value;

  @override
  List<Object?> get props => [value];

  @override
  bool? get stringify => true;
}

class BytesLiteralExpr extends Equatable implements ConstExpression {
  BytesLiteralExpr(this.value);

  @override
  final List<int> value;

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

class ListExpr extends Equatable implements Expr {
  ListExpr(this.elements);

  final List<Expr> elements;

  @override
  List<Object?> get props => [elements];
}

class CreateStructEntry {
  CreateStructEntry(this.key, this.value);

  // In the original, key is wrapped into KeyType.
  // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/vendor/google.golang.org/genproto/googleapis/api/expr/v1alpha1/syntax.pb.go#L1220
  final Expr key;
  final Expr value;
}

// My own creation, just so that parser.visit keeps returning Expr instead of
// dynamic like in cel-go.
class CreateStructEntryListExpr extends Equatable implements Expr {
  CreateStructEntryListExpr(this.entries);

  final List<CreateStructEntry> entries;

  @override
  List<Object?> get props => [entries];
}

class MapExpr extends Equatable implements Expr {
  MapExpr(this.entries);

  final List<CreateStructEntry> entries;

  @override
  List<Object?> get props => [entries];
}
