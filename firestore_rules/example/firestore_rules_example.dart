import 'package:antlr4/antlr4.dart';
import 'package:firestore_rules/FirestoreRulesLexer.dart';
import 'package:firestore_rules/FirestoreRulesParser.dart';

bool match(ParserRuleContext pathRule, String concreteDocumentPath) {
  print('matching ${pathRule.text} against $concreteDocumentPath');
  Map<String, String> variables = {};
  final concreteSegments = concreteDocumentPath.split('/');
  if (concreteSegments.length != pathRule.childCount) {
    return false;
  }
  for (var i = 0; i < pathRule.childCount; i++) {
    final segment = pathRule.getChild(i)!;
    final concreteSegment = concreteSegments[i];
    final nameOrVariable = segment.getChild(1)!;
    final text = nameOrVariable.text;
    if (nameOrVariable is TerminalNode) {
      // Token ==> NAME.
      print('name $text');
      if (text != concreteSegment) {
        return false;
      }
    } else {
      // Rule ==> VARIABLE.
      // No check. We populate the map.
      print('variable $text');
      final variable = nameOrVariable;
      // This is the name without the { }.
      final variableName = variable.getChild(1)!.text!;
      variables[variableName] = concreteSegment;
    }
  }
  print(variables);
  return true;
}

class TreeShapeListener implements ParseTreeListener {
  TreeShapeListener(this.ruleNames, this.tokenTypeNames);

  List<String> ruleNames, tokenTypeNames;

  @override
  void enterEveryRule(ParserRuleContext ctx) {
    print('Rule ${ruleNames[ctx.ruleIndex]}: ${ctx.text}');
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
    if (ctx.ruleIndex == RULE_path) {
      print(match(ctx, 'databases/mydb/documents'));
      print(match(ctx, 'users/abcd'));
    }
  }

  @override
  void exitEveryRule(ParserRuleContext node) {}

  @override
  void visitErrorNode(ErrorNode node) {}

  @override
  void visitTerminal(TerminalNode node) {}
}

void main(List<String> args) async {
  FirestoreRulesLexer.checkVersion();
  FirestoreRulesParser.checkVersion();
  final input = await InputStream.fromPath(args[0]);
  final lexer = FirestoreRulesLexer(input);
  final tokens = CommonTokenStream(lexer);
  final parser = FirestoreRulesParser(tokens);
  parser.addErrorListener(DiagnosticErrorListener());
  parser.buildParseTree = true;
  final tree = parser.rulesDefinition();
  ParseTreeWalker.DEFAULT
      .walk(TreeShapeListener(parser.ruleNames, lexer.ruleNames), tree);

  // Given a concrete path, find the first match whose path pattern matches.
}
