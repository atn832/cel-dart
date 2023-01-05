import 'package:antlr4/antlr4.dart';

import '../cel/expr.dart';
import 'gen/CELLexer.dart';
import 'gen/CELParser.dart';

/// Low-level Parser that parses CEL code into an [Expr]. Exposed for testing
/// purposes. Most users should use [Environment.compile] insetad. Based on
/// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L359-L443.
class Parser {
  Expr parse(String input) {
    final lexer = CELLexer(InputStream.fromString(input));
    final tokens = CommonTokenStream(lexer);
    final parser = CELParser(tokens);
    parser.addErrorListener(DiagnosticErrorListener());
    parser.buildParseTree = true;
    final tree = parser.start();
    return visit(tree);
  }
}

Expr visit(ParseTree tree) {
  tree = unnest(tree);
  if (tree is StartContext) {
    return visitStart(tree);
  }
  if (tree is ExprContext) {
    return visitExpr(tree);
  }
  if (tree is ConditionalOrContext) {
    return visitConditionalOr(tree);
  }
  if (tree is ConditionalAndContext) {
    return visitConditionalAnd(tree);
  }
  if (tree is RelationContext) {
    return visitRelation(tree);
  }
  if (tree is CalcContext) {
    return visitCalc(tree);
  }
  if (tree is UnaryContext) {
    return visitUnary(tree);
  }
  if (tree is MemberCallContext) {
    return visitMemberCall(tree);
  }
  if (tree is SelectContext) {
    return visitSelect(tree);
  }
  if (tree is StringContext) {
    return visitString(tree);
  }
  if (tree is BoolTrueContext) {
    return visitBoolTrue(tree);
  }
  if (tree is BoolFalseContext) {
    return visitBoolFalse(tree);
  }
  if (tree is IntContext) {
    return visitInt(tree);
  }
  if (tree is UintContext) {
    return visitUint(tree);
  }
  if (tree is DoubleContext) {
    return visitDouble(tree);
  }
  if (tree is BytesContext) {
    return visitBytes(tree);
  }
  if (tree is NullContext) {
    return visitNull(tree);
  }
  if (tree is IdentOrGlobalCallContext) {
    return visitIdentOrGlobalCall(tree);
  }
  throw UnsupportedError(
      'Unknown parse element ${tree.text} of type ${tree.runtimeType}');
}

Expr visitBytes(BytesContext tree) {
  // Looks like `b"abc"`.
  // Gotta remove the starting 'b' and unquote the rest.
  return BytesLiteralExpr(unquote(tree.text.substring(1)).codeUnits);
}

Expr visitDouble(DoubleContext tree) {
  return DoubleLiteralExpr((double.parse(tree.text)));
}

Expr visitInt(IntContext tree) {
  return IntLiteralExpr((int.parse(tree.text)));
}

Expr visitUint(UintContext tree) {
  // trim the 'u' designator included in the uint literal.
  final text = tree.text.substring(0, tree.text.length - 1);
  // Small shortcut: reuse IntLiteralExpr.
  return IntLiteralExpr((int.parse(text)));
}

Expr visitNull(NullContext tree) {
  return NullLiteralExpr();
}

Expr visitBoolTrue(BoolTrueContext tree) {
  return BoolLiteralExpr((true));
}

Expr visitBoolFalse(BoolFalseContext tree) {
  return BoolLiteralExpr((false));
}

Expr visitStart(StartContext c) {
  return visit(c.expr()!);
}

Expr visitExpr(ExprContext c) {
  final result = visit(c.e!);
  if (c.op == null) {
    return result;
  }
  final ifTrue = visit(c.e1!);
  final ifFalse = visit(c.e2!);
  // TODO: convert op using the same mapping as https://github.com/google/cel-go/blob/master/common/operators/operators.go.
  // TODO: support `e ? e1 : e2`. See https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/gen/CEL.g4#L25
  // and https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L459.
  return CallExpr(function: c.op!.text!, args: [ifTrue, ifFalse]);
}

Expr visitConditionalOr(ConditionalOrContext tree) {
  // TODO: use a balancer like in https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L463-L476.
  return conditionalOrFromConditionalAndContexts(
      findOperator('||'), [tree.e!, ...tree.e1]);
}

Expr conditionalOrFromConditionalAndContexts(
    String function, List<ParserRuleContext> conditionalAndContexts) {
  if (conditionalAndContexts.length == 1) {
    return visit(conditionalAndContexts.first);
  }
  return CallExpr(function: function, args: [
    visit(conditionalAndContexts.first),
    conditionalOrFromConditionalAndContexts(
        function, conditionalAndContexts.sublist(1))
  ]);
}

Expr visitConditionalAnd(ConditionalAndContext tree) {
  return conditionalOrFromConditionalAndContexts(
      findOperator('&&'), [tree.e!, ...tree.e1]);
}

Expr visitCalc(CalcContext tree) {
  return CallExpr(
      function: findOperator(tree.op!.text!),
      args: [visit(tree.getChild(0)!), visit(tree.getChild(1)!)]);
}

Expr visitUnary(UnaryContext tree) {
  return StringLiteralExpr(('<<error>>'));
}

Expr visitMemberCall(MemberCallContext tree) {
  final operand = visit(tree.member()!);
  final id = tree.id!.text!;
  // TODO: I'm assuming it is a Select. Not parsing Member properly. See
  // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L387-L396.
  return SelectExpr(field: id, operand: operand);
}

Expr visitSelect(SelectContext tree) {
  final operand = visit(tree.member()!);
  final id = tree.id!.text!;
  return SelectExpr(field: id, operand: operand);
}

Expr visitRelation(RelationContext tree) {
  final op = findOperator(tree.op!.text!);
  return CallExpr(
      function: op, args: [visit(tree.relation(0)!), visit(tree.relation(1)!)]);
}

Expr visitString(StringContext tree) {
  return StringLiteralExpr(unquote(tree.text));
}

// Based on
// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L950.
// It unwraps the "concrete" ParseTree. For example, a Member rule is wrapped
// by an empty Unary, which is wrapped by an empty Relation (with no
// operator).
ParseTree unnest(ParseTree t) {
  if (t is ExprContext) {
    return t.op != null
        ? t // conditionalOr op='?' conditionalOr : expr
        : unnest(t.e!); // conditionalOr
  }
  if (t is ConditionalOrContext) {
    return t.ops.isNotEmpty
        ? t // conditionalAnd (ops=|| conditionalAnd)*
        : unnest(t.e!); // conditionalAnd
  }
  if (t is ConditionalAndContext) {
    return t.ops.isNotEmpty
        ? t // relation (ops=&& relation)*
        : unnest(t.e!); // relation
  }
  if (t is RelationContext) {
    return t.op != null
        ? t // relation op relation
        : unnest(t.calc()!); // calc
  }
  if (t is CalcContext) {
    return t.op != null
        ? t // calc op calc
        : unnest(t.unary()!); // unary
  }
  if (t is MemberExprContext) {
    return unnest(t.member()!);
  }
  if (t is PrimaryExprContext) {
    return unnest(t.primary()!);
  }
  if (t is NestedContext) {
    return unnest(t.e!);
  }
  if (t is ConstantLiteralContext) {
    return unnest(t.literal()!);
  }
  // TODO: port the remaining types.
  return t;
}

// Based on
// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L652.
Expr visitIdentOrGlobalCall(IdentOrGlobalCallContext tree) {
  if (tree.op != null) {
    // TODO: Handle global call or macro.
    throw Exception();
  }
  // TODO: Check for reserved identifiers and throw errors.

  return IdentExpr('${tree.leadingDot?.text ?? ''}${tree.id!.text!}');
}

// TODO: instead, check against the map of operators. For example in becomes
// @in, not _in_. See
// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L515.
String findOperator(String operator) => '_${operator}_';

// TODO: implement unescape in the unquote. See
// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L843.
String unquote(String text) => text.substring(1, text.length - 1);
