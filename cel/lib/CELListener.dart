// Generated from CEL.g4 by ANTLR 4.11.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'CELParser.dart';

/// This abstract class defines a complete listener for a parse tree produced by
/// [CELParser].
abstract class CELListener extends ParseTreeListener {
  /// Enter a parse tree produced by [CELParser.start].
  /// [ctx] the parse tree
  void enterStart(StartContext ctx);
  /// Exit a parse tree produced by [CELParser.start].
  /// [ctx] the parse tree
  void exitStart(StartContext ctx);

  /// Enter a parse tree produced by [CELParser.expr].
  /// [ctx] the parse tree
  void enterExpr(ExprContext ctx);
  /// Exit a parse tree produced by [CELParser.expr].
  /// [ctx] the parse tree
  void exitExpr(ExprContext ctx);

  /// Enter a parse tree produced by [CELParser.conditionalOr].
  /// [ctx] the parse tree
  void enterConditionalOr(ConditionalOrContext ctx);
  /// Exit a parse tree produced by [CELParser.conditionalOr].
  /// [ctx] the parse tree
  void exitConditionalOr(ConditionalOrContext ctx);

  /// Enter a parse tree produced by [CELParser.conditionalAnd].
  /// [ctx] the parse tree
  void enterConditionalAnd(ConditionalAndContext ctx);
  /// Exit a parse tree produced by [CELParser.conditionalAnd].
  /// [ctx] the parse tree
  void exitConditionalAnd(ConditionalAndContext ctx);

  /// Enter a parse tree produced by [CELParser.relation].
  /// [ctx] the parse tree
  void enterRelation(RelationContext ctx);
  /// Exit a parse tree produced by [CELParser.relation].
  /// [ctx] the parse tree
  void exitRelation(RelationContext ctx);

  /// Enter a parse tree produced by [CELParser.calc].
  /// [ctx] the parse tree
  void enterCalc(CalcContext ctx);
  /// Exit a parse tree produced by [CELParser.calc].
  /// [ctx] the parse tree
  void exitCalc(CalcContext ctx);

  /// Enter a parse tree produced by the [MemberExpr]
  /// labeled alternative in [file.parserName>.unary].
  /// [ctx] the parse tree
  void enterMemberExpr(MemberExprContext ctx);
  /// Exit a parse tree produced by the [MemberExpr]
  /// labeled alternative in [CELParser.unary].
  /// [ctx] the parse tree
  void exitMemberExpr(MemberExprContext ctx);

  /// Enter a parse tree produced by the [LogicalNot]
  /// labeled alternative in [file.parserName>.unary].
  /// [ctx] the parse tree
  void enterLogicalNot(LogicalNotContext ctx);
  /// Exit a parse tree produced by the [LogicalNot]
  /// labeled alternative in [CELParser.unary].
  /// [ctx] the parse tree
  void exitLogicalNot(LogicalNotContext ctx);

  /// Enter a parse tree produced by the [Negate]
  /// labeled alternative in [file.parserName>.unary].
  /// [ctx] the parse tree
  void enterNegate(NegateContext ctx);
  /// Exit a parse tree produced by the [Negate]
  /// labeled alternative in [CELParser.unary].
  /// [ctx] the parse tree
  void exitNegate(NegateContext ctx);

  /// Enter a parse tree produced by the [MemberCall]
  /// labeled alternative in [file.parserName>.member].
  /// [ctx] the parse tree
  void enterMemberCall(MemberCallContext ctx);
  /// Exit a parse tree produced by the [MemberCall]
  /// labeled alternative in [CELParser.member].
  /// [ctx] the parse tree
  void exitMemberCall(MemberCallContext ctx);

  /// Enter a parse tree produced by the [Select]
  /// labeled alternative in [file.parserName>.member].
  /// [ctx] the parse tree
  void enterSelect(SelectContext ctx);
  /// Exit a parse tree produced by the [Select]
  /// labeled alternative in [CELParser.member].
  /// [ctx] the parse tree
  void exitSelect(SelectContext ctx);

  /// Enter a parse tree produced by the [PrimaryExpr]
  /// labeled alternative in [file.parserName>.member].
  /// [ctx] the parse tree
  void enterPrimaryExpr(PrimaryExprContext ctx);
  /// Exit a parse tree produced by the [PrimaryExpr]
  /// labeled alternative in [CELParser.member].
  /// [ctx] the parse tree
  void exitPrimaryExpr(PrimaryExprContext ctx);

  /// Enter a parse tree produced by the [Index]
  /// labeled alternative in [file.parserName>.member].
  /// [ctx] the parse tree
  void enterIndex(IndexContext ctx);
  /// Exit a parse tree produced by the [Index]
  /// labeled alternative in [CELParser.member].
  /// [ctx] the parse tree
  void exitIndex(IndexContext ctx);

  /// Enter a parse tree produced by the [IdentOrGlobalCall]
  /// labeled alternative in [file.parserName>.primary].
  /// [ctx] the parse tree
  void enterIdentOrGlobalCall(IdentOrGlobalCallContext ctx);
  /// Exit a parse tree produced by the [IdentOrGlobalCall]
  /// labeled alternative in [CELParser.primary].
  /// [ctx] the parse tree
  void exitIdentOrGlobalCall(IdentOrGlobalCallContext ctx);

  /// Enter a parse tree produced by the [Nested]
  /// labeled alternative in [file.parserName>.primary].
  /// [ctx] the parse tree
  void enterNested(NestedContext ctx);
  /// Exit a parse tree produced by the [Nested]
  /// labeled alternative in [CELParser.primary].
  /// [ctx] the parse tree
  void exitNested(NestedContext ctx);

  /// Enter a parse tree produced by the [CreateList]
  /// labeled alternative in [file.parserName>.primary].
  /// [ctx] the parse tree
  void enterCreateList(CreateListContext ctx);
  /// Exit a parse tree produced by the [CreateList]
  /// labeled alternative in [CELParser.primary].
  /// [ctx] the parse tree
  void exitCreateList(CreateListContext ctx);

  /// Enter a parse tree produced by the [CreateStruct]
  /// labeled alternative in [file.parserName>.primary].
  /// [ctx] the parse tree
  void enterCreateStruct(CreateStructContext ctx);
  /// Exit a parse tree produced by the [CreateStruct]
  /// labeled alternative in [CELParser.primary].
  /// [ctx] the parse tree
  void exitCreateStruct(CreateStructContext ctx);

  /// Enter a parse tree produced by the [CreateMessage]
  /// labeled alternative in [file.parserName>.primary].
  /// [ctx] the parse tree
  void enterCreateMessage(CreateMessageContext ctx);
  /// Exit a parse tree produced by the [CreateMessage]
  /// labeled alternative in [CELParser.primary].
  /// [ctx] the parse tree
  void exitCreateMessage(CreateMessageContext ctx);

  /// Enter a parse tree produced by the [ConstantLiteral]
  /// labeled alternative in [file.parserName>.primary].
  /// [ctx] the parse tree
  void enterConstantLiteral(ConstantLiteralContext ctx);
  /// Exit a parse tree produced by the [ConstantLiteral]
  /// labeled alternative in [CELParser.primary].
  /// [ctx] the parse tree
  void exitConstantLiteral(ConstantLiteralContext ctx);

  /// Enter a parse tree produced by [CELParser.exprList].
  /// [ctx] the parse tree
  void enterExprList(ExprListContext ctx);
  /// Exit a parse tree produced by [CELParser.exprList].
  /// [ctx] the parse tree
  void exitExprList(ExprListContext ctx);

  /// Enter a parse tree produced by [CELParser.listInit].
  /// [ctx] the parse tree
  void enterListInit(ListInitContext ctx);
  /// Exit a parse tree produced by [CELParser.listInit].
  /// [ctx] the parse tree
  void exitListInit(ListInitContext ctx);

  /// Enter a parse tree produced by [CELParser.fieldInitializerList].
  /// [ctx] the parse tree
  void enterFieldInitializerList(FieldInitializerListContext ctx);
  /// Exit a parse tree produced by [CELParser.fieldInitializerList].
  /// [ctx] the parse tree
  void exitFieldInitializerList(FieldInitializerListContext ctx);

  /// Enter a parse tree produced by [CELParser.optField].
  /// [ctx] the parse tree
  void enterOptField(OptFieldContext ctx);
  /// Exit a parse tree produced by [CELParser.optField].
  /// [ctx] the parse tree
  void exitOptField(OptFieldContext ctx);

  /// Enter a parse tree produced by [CELParser.mapInitializerList].
  /// [ctx] the parse tree
  void enterMapInitializerList(MapInitializerListContext ctx);
  /// Exit a parse tree produced by [CELParser.mapInitializerList].
  /// [ctx] the parse tree
  void exitMapInitializerList(MapInitializerListContext ctx);

  /// Enter a parse tree produced by [CELParser.optExpr].
  /// [ctx] the parse tree
  void enterOptExpr(OptExprContext ctx);
  /// Exit a parse tree produced by [CELParser.optExpr].
  /// [ctx] the parse tree
  void exitOptExpr(OptExprContext ctx);

  /// Enter a parse tree produced by the [Int]
  /// labeled alternative in [file.parserName>.literal].
  /// [ctx] the parse tree
  void enterInt(IntContext ctx);
  /// Exit a parse tree produced by the [Int]
  /// labeled alternative in [CELParser.literal].
  /// [ctx] the parse tree
  void exitInt(IntContext ctx);

  /// Enter a parse tree produced by the [Uint]
  /// labeled alternative in [file.parserName>.literal].
  /// [ctx] the parse tree
  void enterUint(UintContext ctx);
  /// Exit a parse tree produced by the [Uint]
  /// labeled alternative in [CELParser.literal].
  /// [ctx] the parse tree
  void exitUint(UintContext ctx);

  /// Enter a parse tree produced by the [Double]
  /// labeled alternative in [file.parserName>.literal].
  /// [ctx] the parse tree
  void enterDouble(DoubleContext ctx);
  /// Exit a parse tree produced by the [Double]
  /// labeled alternative in [CELParser.literal].
  /// [ctx] the parse tree
  void exitDouble(DoubleContext ctx);

  /// Enter a parse tree produced by the [String]
  /// labeled alternative in [file.parserName>.literal].
  /// [ctx] the parse tree
  void enterString(StringContext ctx);
  /// Exit a parse tree produced by the [String]
  /// labeled alternative in [CELParser.literal].
  /// [ctx] the parse tree
  void exitString(StringContext ctx);

  /// Enter a parse tree produced by the [Bytes]
  /// labeled alternative in [file.parserName>.literal].
  /// [ctx] the parse tree
  void enterBytes(BytesContext ctx);
  /// Exit a parse tree produced by the [Bytes]
  /// labeled alternative in [CELParser.literal].
  /// [ctx] the parse tree
  void exitBytes(BytesContext ctx);

  /// Enter a parse tree produced by the [BoolTrue]
  /// labeled alternative in [file.parserName>.literal].
  /// [ctx] the parse tree
  void enterBoolTrue(BoolTrueContext ctx);
  /// Exit a parse tree produced by the [BoolTrue]
  /// labeled alternative in [CELParser.literal].
  /// [ctx] the parse tree
  void exitBoolTrue(BoolTrueContext ctx);

  /// Enter a parse tree produced by the [BoolFalse]
  /// labeled alternative in [file.parserName>.literal].
  /// [ctx] the parse tree
  void enterBoolFalse(BoolFalseContext ctx);
  /// Exit a parse tree produced by the [BoolFalse]
  /// labeled alternative in [CELParser.literal].
  /// [ctx] the parse tree
  void exitBoolFalse(BoolFalseContext ctx);

  /// Enter a parse tree produced by the [Null]
  /// labeled alternative in [file.parserName>.literal].
  /// [ctx] the parse tree
  void enterNull(NullContext ctx);
  /// Exit a parse tree produced by the [Null]
  /// labeled alternative in [CELParser.literal].
  /// [ctx] the parse tree
  void exitNull(NullContext ctx);
}