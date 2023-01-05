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

class StringLiteralExpr extends Expr {
  late final String value;
}

class IdentExpr extends Expr {
  late final String name;
}
