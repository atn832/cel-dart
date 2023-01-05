import 'package:antlr4/antlr4.dart';
import 'package:cel/CELLexer.dart';
import 'package:cel/CELParser.dart';

class TreeShapeListener implements ParseTreeListener {
  TreeShapeListener(this.ruleNames, this.tokenTypeNames);

  List<String> ruleNames, tokenTypeNames;

  @override
  void enterEveryRule(ParserRuleContext ctx) {
    print(
        '${''.padRight(ctx.depth())} Rule ${ruleNames[ctx.ruleIndex]}: ${ctx.text}');
    if (ctx is ExprContext) {
      print('expression');
      print(ctx.e!.text);
      print(ctx.op);
      print(ctx.e1);
      print(ctx.e2);
    }
    for (final child in ctx.children ?? <ParseTree>[]) {
      if (child is! TerminalNode) {
        continue;
      }
      final s = child.symbol;
      // Skip EOF.
      if (s.type < 0) {
        continue;
      }
      print('Token ${tokenTypeNames[s.type - 1]} ${s.text}');
    }
  }

  @override
  void exitEveryRule(ParserRuleContext node) {}

  @override
  void visitErrorNode(ErrorNode node) {}

  @override
  void visitTerminal(TerminalNode node) {}
}

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

// Based on https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L359-L443.
class ExprParser {
  Expr parse(String input) {
    final lexer = CELLexer(InputStream.fromString(input));
    final tokens = CommonTokenStream(lexer);
    final parser = CELParser(tokens);
    parser.addErrorListener(DiagnosticErrorListener());
    parser.buildParseTree = true;
    final tree = parser.start();
    return visit(tree);
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
    if (tree is IdentOrGlobalCallContext) {
      return visitIdentOrGlobalCall(tree);
    }
    print('Unknown parse element ${tree.text}');
    print(tree.runtimeType);
    return Expr();
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
    return CallExpr()
      ..function = c.op!.text!
      ..args = [ifTrue, ifFalse];
  }

  Expr visitConditionalOr(ConditionalOrContext tree) {
    // TODO: use a balancer like in https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L463-L476.
    return conditionalOrFromConditionalAndContexts(
        '_||_', [tree.e!, ...tree.e1]);
  }

  Expr conditionalOrFromConditionalAndContexts(
      String function, List<ParserRuleContext> conditionalAndContexts) {
    if (conditionalAndContexts.length == 1) {
      return visit(conditionalAndContexts.first);
    }
    return CallExpr()
      ..function = function
      ..args = [
        conditionalAndContexts.first,
        conditionalOrFromConditionalAndContexts(
            function, conditionalAndContexts.sublist(1))
      ];
  }

  Expr visitConditionalAnd(ConditionalAndContext tree) {
    return conditionalOrFromConditionalAndContexts(
        '_&&_', [tree.e!, ...tree.e1]);
  }

  Expr visitCalc(CalcContext tree) {
    // TODO: check against the map of operators. For example in becomes @in, not
    // _in_. See
    // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L515.
    return CallExpr()
      ..function = '_${tree.op!.text!}_'
      ..args = [visit(tree.getChild(0)!), visit(tree.getChild(1)!)];
  }

  Expr visitUnary(UnaryContext tree) {
    return StringLiteralExpr()..value = '<<error>>';
  }

  Expr visitMemberCall(MemberCallContext tree) {
    final operand = visit(tree.member()!);
    final id = tree.id!.text!;
    // TODO: I'm assuming it is a Select. Not parsing Member properly. See
    // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L387-L396.
    return SelectExpr()
      ..field = id
      ..operand = operand;
  }

  Expr visitSelect(SelectContext tree) {
    final operand = visit(tree.member()!);
    final id = tree.id!.text!;
    return SelectExpr()
      ..field = id
      ..operand = operand;
  }

  Expr visitRelation(RelationContext tree) {
    // TODO: convert to the Operator name properly.
    final op = tree.op!.text!;
    return CallExpr()
      ..function = op
      ..args = [visit(tree.relation(0)!), visit(tree.relation(1)!)];
  }

  Expr visitString(StringContext tree) {
    return StringLiteralExpr()
      // Unquote.
      // TODO: implement unescape in the unquote. See
      // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L843.
      ..value = tree.text.substring(1, tree.text.length - 1);
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

    return IdentExpr()
      ..name = '${tree.leadingDot?.text ?? ''}${tree.id!.text!}';
  }
}

void main() {
  // final input = 'request.auth != null && request.auth.uid == userId';
  // From CEL Colab, exercise 2.
  final input = "request.auth.claims.group == 'admin'";
  final lexer = CELLexer(InputStream.fromString(input));
  final tokens = CommonTokenStream(lexer);
  final parser = CELParser(tokens);
  parser.addErrorListener(DiagnosticErrorListener());
  parser.buildParseTree = true;
  final tree = parser.start();
  ParseTreeWalker.DEFAULT
      .walk(TreeShapeListener(parser.ruleNames, lexer.ruleNames), tree);

  final e = ExprParser().parse(input);
  print(e);
}
