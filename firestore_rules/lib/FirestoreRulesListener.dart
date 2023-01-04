// Generated from FirestoreRules.g4 by ANTLR 4.11.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'FirestoreRulesParser.dart';

/// This abstract class defines a complete listener for a parse tree produced by
/// [FirestoreRulesParser].
abstract class FirestoreRulesListener extends ParseTreeListener {
  /// Enter a parse tree produced by [FirestoreRulesParser.rulesDefinition].
  /// [ctx] the parse tree
  void enterRulesDefinition(RulesDefinitionContext ctx);
  /// Exit a parse tree produced by [FirestoreRulesParser.rulesDefinition].
  /// [ctx] the parse tree
  void exitRulesDefinition(RulesDefinitionContext ctx);

  /// Enter a parse tree produced by [FirestoreRulesParser.rulesVersion].
  /// [ctx] the parse tree
  void enterRulesVersion(RulesVersionContext ctx);
  /// Exit a parse tree produced by [FirestoreRulesParser.rulesVersion].
  /// [ctx] the parse tree
  void exitRulesVersion(RulesVersionContext ctx);

  /// Enter a parse tree produced by [FirestoreRulesParser.service].
  /// [ctx] the parse tree
  void enterService(ServiceContext ctx);
  /// Exit a parse tree produced by [FirestoreRulesParser.service].
  /// [ctx] the parse tree
  void exitService(ServiceContext ctx);

  /// Enter a parse tree produced by [FirestoreRulesParser.matchRule].
  /// [ctx] the parse tree
  void enterMatchRule(MatchRuleContext ctx);
  /// Exit a parse tree produced by [FirestoreRulesParser.matchRule].
  /// [ctx] the parse tree
  void exitMatchRule(MatchRuleContext ctx);

  /// Enter a parse tree produced by [FirestoreRulesParser.allow].
  /// [ctx] the parse tree
  void enterAllow(AllowContext ctx);
  /// Exit a parse tree produced by [FirestoreRulesParser.allow].
  /// [ctx] the parse tree
  void exitAllow(AllowContext ctx);

  /// Enter a parse tree produced by [FirestoreRulesParser.path].
  /// [ctx] the parse tree
  void enterPath(PathContext ctx);
  /// Exit a parse tree produced by [FirestoreRulesParser.path].
  /// [ctx] the parse tree
  void exitPath(PathContext ctx);

  /// Enter a parse tree produced by [FirestoreRulesParser.pathSegment].
  /// [ctx] the parse tree
  void enterPathSegment(PathSegmentContext ctx);
  /// Exit a parse tree produced by [FirestoreRulesParser.pathSegment].
  /// [ctx] the parse tree
  void exitPathSegment(PathSegmentContext ctx);

  /// Enter a parse tree produced by [FirestoreRulesParser.variable].
  /// [ctx] the parse tree
  void enterVariable(VariableContext ctx);
  /// Exit a parse tree produced by [FirestoreRulesParser.variable].
  /// [ctx] the parse tree
  void exitVariable(VariableContext ctx);
}