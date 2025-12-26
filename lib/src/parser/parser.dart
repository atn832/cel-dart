import 'package:collection/collection.dart';
import 'package:antlr4/antlr4.dart';
import 'package:cel/src/operators/operators.dart';

import 'package:cel/gen/CELLexer.dart';
import 'package:cel/gen/CELParser.dart';

import '../cel/expr.dart';

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
  if (tree is LogicalNotContext) {
    return visitLogicalNot(tree);
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
  if (tree is CreateListContext) {
    return visitCreateList(tree);
  }
  if (tree is CreateStructContext) {
    return visitCreateStruct(tree);
  }
  if (tree is MapInitializerListContext) {
    return visitMapInitializerList(tree);
  }
  if (tree is IndexContext) {
    return visitIndex(tree);
  }

  throw UnsupportedError(
      'Unknown parse element ${tree.text} of type ${tree.runtimeType}');
}

Expr visitIndex(IndexContext tree) {
  // Skipped porting globalCallOrMacro.
  final index = visit(tree.index!);
  return CallExpr(
      function: Operators.index_.name,
      target: visit(tree.member()!),
      args: [index]);
}

// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L692
Expr visitMapInitializerList(MapInitializerListContext tree) {
  assert(tree.cols.length == tree.keys.length);
  assert(tree.cols.length == tree.values.length);

  // Unlike cel-go, we wrap it in an Expr to avoid using dynamic.
  return CreateStructEntryListExpr(
      IterableZip([tree.keys, tree.values]).map((keyValue) {
    final key = visit((keyValue.first as OptExprContext).e!);
    final value = visit(keyValue.last);
    return CreateStructEntry(key, value);
  }).toList());
}

// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L682
Expr visitCreateStruct(CreateStructContext tree) {
  final entries = tree.entries != null
      ? (visit(tree.entries!) as CreateStructEntryListExpr).entries
      : <CreateStructEntry>[];
  // For some reason, in the original, they wrap the reslult like this:
  // Expr(exprKind: Expr_StructExpr(structExpr: Expr_CreateStruct(entries: entries))).
  // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/helper.go#L130
  return MapExpr(entries);
}

Expr visitLogicalNot(LogicalNotContext tree) {
  final target = visit(tree.member()!);
  // Skipped: global call or macro.

  return CallExpr(function: Operators.logicalNot.name, args: [target]);
}

Expr visitCreateList(CreateListContext tree) {
  final elements = visitListInit(tree.elems);
  return ListExpr(elements);
}

// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L807
List<Expr> visitListInit(ListInitContext? elems) {
  if (elems == null) {
    return [];
  }
  // Skipped porting of Optionals.

  return elems.elems.map((e) => visit(e.e!)).toList();
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
  final condition = result;
  final ifTrue = visit(c.e1!);
  final ifFalse = visit(c.e2!);

  return CallExpr(
      function: Operators.conditional.name, args: [condition, ifTrue, ifFalse]);
}

Expr visitConditionalOr(ConditionalOrContext tree) {
  // TODO: use a balancer like in https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L463-L476.
  return conditionalOrFromConditionalAndContexts(
      Operators.logicalOr.name, [tree.e!, ...tree.e1]);
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
      Operators.logicalAnd.name, [tree.e!, ...tree.e1]);
}

Expr visitCalc(CalcContext tree) {
  return CallExpr(
      function: findOperator(tree.op!.text!),
      args: [visit(tree.calc(0)!), visit(tree.calc(1)!)]);
}

Expr visitUnary(UnaryContext tree) {
  return StringLiteralExpr(('<<error>>'));
}

Expr visitMemberCall(MemberCallContext tree) {
  final operand = visit(tree.member()!);
  final id = tree.id!.text!;
  // TODO: I'm assuming it is a Select. Not parsing Member properly. See
  // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L387-L396.

  // Skipped porting visitExprList and visitSlice. They don't seem to be useful.
  // Skipped receiverCallOrMacro.
  return CallExpr(
      function: id,
      target: operand,
      args: tree.args!.e.map((e) => visit(e)).toList());
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
  // print('unnest: Unknown type ${t.runtimeType}');
  return t;
}

// Based on
// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L652.
Expr visitIdentOrGlobalCall(IdentOrGlobalCallContext tree) {
  final name = '${tree.leadingDot?.text ?? ''}${tree.id!.text!}';
  if (tree.op != null) {
    // TODO: Handle global call or macro properly.
    return CallExpr(
        function: name, args: tree.args!.e.map((e) => visit(e)).toList());
  }
  // TODO: Check for reserved identifiers and throw errors.

  return IdentExpr(name);
}

String findOperator(String operator) => Operators.operators[operator]!.name;

// TODO: implement unescape in the unquote. See
// https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L843.
String unquote(String text) => text.substring(1, text.length - 1);
