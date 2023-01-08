// Based on https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/cel/env.go#L39.
import 'package:equatable/equatable.dart';

import 'expr.dart';

class Ast extends Equatable {
  Ast(this.expression);

  final Expr expression;

  @override
  List<Object?> get props => [expression];

  @override
  bool? get stringify => true;
}
