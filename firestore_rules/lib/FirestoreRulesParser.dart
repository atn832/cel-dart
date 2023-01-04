// Generated from FirestoreRules.g4 by ANTLR 4.11.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'FirestoreRulesListener.dart';
import 'FirestoreRulesBaseListener.dart';
const int RULE_rulesDefinition = 0, RULE_rulesVersion = 1, RULE_service = 2, 
          RULE_matchRule = 3, RULE_allow = 4, RULE_path = 5, RULE_pathSegment = 6, 
          RULE_variable = 7;
class FirestoreRulesParser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.11.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, 
                   TOKEN_T__4 = 5, TOKEN_T__5 = 6, TOKEN_T__6 = 7, TOKEN_T__7 = 8, 
                   TOKEN_T__8 = 9, TOKEN_T__9 = 10, TOKEN_T__10 = 11, TOKEN_T__11 = 12, 
                   TOKEN_ACCESS = 13, TOKEN_NAME = 14, TOKEN_STRING = 15, 
                   TOKEN_CES_EXPRESSION = 16, TOKEN_WHITESPACE = 17, TOKEN_COMMENT = 18;

  @override
  final List<String> ruleNames = [
    'rulesDefinition', 'rulesVersion', 'service', 'matchRule', 'allow', 
    'path', 'pathSegment', 'variable'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "'rules_version'", "'='", "'service'", "'cloud.firestore'", 
      "'{'", "'}'", "'match'", "'allow'", "','", "':'", "'/'", "'=**'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, null, null, null, null, null, null, null, null, 
      null, null, "ACCESS", "NAME", "STRING", "CES_EXPRESSION", "WHITESPACE", 
      "COMMENT"
  ];
  static final Vocabulary VOCABULARY = VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }

  @override
  String get grammarFileName => 'FirestoreRules.g4';

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  ATN getATN() {
   return _ATN;
  }

  FirestoreRulesParser(TokenStream input) : super(input) {
    interpreter = ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
  }

  RulesDefinitionContext rulesDefinition() {
    dynamic _localctx = RulesDefinitionContext(context, state);
    enterRule(_localctx, 0, RULE_rulesDefinition);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 17;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__0) {
        state = 16;
        rulesVersion();
      }

      state = 20;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__2) {
        state = 19;
        service();
      }

      state = 22;
      match(TOKEN_EOF);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  RulesVersionContext rulesVersion() {
    dynamic _localctx = RulesVersionContext(context, state);
    enterRule(_localctx, 2, RULE_rulesVersion);
    try {
      enterOuterAlt(_localctx, 1);
      state = 24;
      match(TOKEN_T__0);
      state = 25;
      match(TOKEN_T__1);
      state = 26;
      match(TOKEN_STRING);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ServiceContext service() {
    dynamic _localctx = ServiceContext(context, state);
    enterRule(_localctx, 4, RULE_service);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 28;
      match(TOKEN_T__2);
      state = 29;
      match(TOKEN_T__3);
      state = 30;
      match(TOKEN_T__4);
      state = 34;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__6) {
        state = 31;
        matchRule();
        state = 36;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 37;
      match(TOKEN_T__5);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  MatchRuleContext matchRule() {
    dynamic _localctx = MatchRuleContext(context, state);
    enterRule(_localctx, 6, RULE_matchRule);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 39;
      match(TOKEN_T__6);
      state = 40;
      path();
      state = 41;
      match(TOKEN_T__4);
      state = 46;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__6 || _la == TOKEN_T__7) {
        state = 44;
        errorHandler.sync(this);
        switch (tokenStream.LA(1)!) {
        case TOKEN_T__7:
          state = 42;
          allow();
          break;
        case TOKEN_T__6:
          state = 43;
          matchRule();
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 48;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 49;
      match(TOKEN_T__5);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  AllowContext allow() {
    dynamic _localctx = AllowContext(context, state);
    enterRule(_localctx, 8, RULE_allow);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 51;
      match(TOKEN_T__7);
      state = 52;
      match(TOKEN_ACCESS);
      state = 57;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_T__8) {
        state = 53;
        match(TOKEN_T__8);
        state = 54;
        match(TOKEN_ACCESS);
        state = 59;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 60;
      match(TOKEN_T__9);
      state = 61;
      match(TOKEN_CES_EXPRESSION);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  PathContext path() {
    dynamic _localctx = PathContext(context, state);
    enterRule(_localctx, 10, RULE_path);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 64; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 63;
        pathSegment();
        state = 66; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_T__10);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  PathSegmentContext pathSegment() {
    dynamic _localctx = PathSegmentContext(context, state);
    enterRule(_localctx, 12, RULE_pathSegment);
    try {
      enterOuterAlt(_localctx, 1);
      state = 68;
      match(TOKEN_T__10);
      state = 71;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_NAME:
        state = 69;
        match(TOKEN_NAME);
        break;
      case TOKEN_T__4:
        state = 70;
        variable();
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  VariableContext variable() {
    dynamic _localctx = VariableContext(context, state);
    enterRule(_localctx, 14, RULE_variable);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 73;
      match(TOKEN_T__4);
      state = 74;
      match(TOKEN_NAME);
      state = 76;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_T__11) {
        state = 75;
        match(TOKEN_T__11);
      }

      state = 78;
      match(TOKEN_T__5);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  static const List<int> _serializedATN = [
      4,1,18,81,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,1,0,3,0,18,8,0,1,0,3,0,21,8,0,1,0,1,0,1,1,1,1,1,1,1,1,1,2,
      1,2,1,2,1,2,5,2,33,8,2,10,2,12,2,36,9,2,1,2,1,2,1,3,1,3,1,3,1,3,1,
      3,5,3,45,8,3,10,3,12,3,48,9,3,1,3,1,3,1,4,1,4,1,4,1,4,5,4,56,8,4,10,
      4,12,4,59,9,4,1,4,1,4,1,4,1,5,4,5,65,8,5,11,5,12,5,66,1,6,1,6,1,6,
      3,6,72,8,6,1,7,1,7,1,7,3,7,77,8,7,1,7,1,7,1,7,0,0,8,0,2,4,6,8,10,12,
      14,0,0,81,0,17,1,0,0,0,2,24,1,0,0,0,4,28,1,0,0,0,6,39,1,0,0,0,8,51,
      1,0,0,0,10,64,1,0,0,0,12,68,1,0,0,0,14,73,1,0,0,0,16,18,3,2,1,0,17,
      16,1,0,0,0,17,18,1,0,0,0,18,20,1,0,0,0,19,21,3,4,2,0,20,19,1,0,0,0,
      20,21,1,0,0,0,21,22,1,0,0,0,22,23,5,0,0,1,23,1,1,0,0,0,24,25,5,1,0,
      0,25,26,5,2,0,0,26,27,5,15,0,0,27,3,1,0,0,0,28,29,5,3,0,0,29,30,5,
      4,0,0,30,34,5,5,0,0,31,33,3,6,3,0,32,31,1,0,0,0,33,36,1,0,0,0,34,32,
      1,0,0,0,34,35,1,0,0,0,35,37,1,0,0,0,36,34,1,0,0,0,37,38,5,6,0,0,38,
      5,1,0,0,0,39,40,5,7,0,0,40,41,3,10,5,0,41,46,5,5,0,0,42,45,3,8,4,0,
      43,45,3,6,3,0,44,42,1,0,0,0,44,43,1,0,0,0,45,48,1,0,0,0,46,44,1,0,
      0,0,46,47,1,0,0,0,47,49,1,0,0,0,48,46,1,0,0,0,49,50,5,6,0,0,50,7,1,
      0,0,0,51,52,5,8,0,0,52,57,5,13,0,0,53,54,5,9,0,0,54,56,5,13,0,0,55,
      53,1,0,0,0,56,59,1,0,0,0,57,55,1,0,0,0,57,58,1,0,0,0,58,60,1,0,0,0,
      59,57,1,0,0,0,60,61,5,10,0,0,61,62,5,16,0,0,62,9,1,0,0,0,63,65,3,12,
      6,0,64,63,1,0,0,0,65,66,1,0,0,0,66,64,1,0,0,0,66,67,1,0,0,0,67,11,
      1,0,0,0,68,71,5,11,0,0,69,72,5,14,0,0,70,72,3,14,7,0,71,69,1,0,0,0,
      71,70,1,0,0,0,72,13,1,0,0,0,73,74,5,5,0,0,74,76,5,14,0,0,75,77,5,12,
      0,0,76,75,1,0,0,0,76,77,1,0,0,0,77,78,1,0,0,0,78,79,5,6,0,0,79,15,
      1,0,0,0,9,17,20,34,44,46,57,66,71,76
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}
class RulesDefinitionContext extends ParserRuleContext {
  TerminalNode? EOF() => getToken(FirestoreRulesParser.TOKEN_EOF, 0);
  RulesVersionContext? rulesVersion() => getRuleContext<RulesVersionContext>(0);
  ServiceContext? service() => getRuleContext<ServiceContext>(0);
  RulesDefinitionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_rulesDefinition;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterRulesDefinition(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitRulesDefinition(this);
  }
}

class RulesVersionContext extends ParserRuleContext {
  TerminalNode? STRING() => getToken(FirestoreRulesParser.TOKEN_STRING, 0);
  RulesVersionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_rulesVersion;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterRulesVersion(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitRulesVersion(this);
  }
}

class ServiceContext extends ParserRuleContext {
  List<MatchRuleContext> matchRules() => getRuleContexts<MatchRuleContext>();
  MatchRuleContext? matchRule(int i) => getRuleContext<MatchRuleContext>(i);
  ServiceContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_service;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterService(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitService(this);
  }
}

class MatchRuleContext extends ParserRuleContext {
  PathContext? path() => getRuleContext<PathContext>(0);
  List<AllowContext> allows() => getRuleContexts<AllowContext>();
  AllowContext? allow(int i) => getRuleContext<AllowContext>(i);
  List<MatchRuleContext> matchRules() => getRuleContexts<MatchRuleContext>();
  MatchRuleContext? matchRule(int i) => getRuleContext<MatchRuleContext>(i);
  MatchRuleContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_matchRule;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterMatchRule(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitMatchRule(this);
  }
}

class AllowContext extends ParserRuleContext {
  List<TerminalNode> ACCESSs() => getTokens(FirestoreRulesParser.TOKEN_ACCESS);
  TerminalNode? ACCESS(int i) => getToken(FirestoreRulesParser.TOKEN_ACCESS, i);
  TerminalNode? CES_EXPRESSION() => getToken(FirestoreRulesParser.TOKEN_CES_EXPRESSION, 0);
  AllowContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_allow;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterAllow(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitAllow(this);
  }
}

class PathContext extends ParserRuleContext {
  List<PathSegmentContext> pathSegments() => getRuleContexts<PathSegmentContext>();
  PathSegmentContext? pathSegment(int i) => getRuleContext<PathSegmentContext>(i);
  PathContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_path;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterPath(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitPath(this);
  }
}

class PathSegmentContext extends ParserRuleContext {
  TerminalNode? NAME() => getToken(FirestoreRulesParser.TOKEN_NAME, 0);
  VariableContext? variable() => getRuleContext<VariableContext>(0);
  PathSegmentContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_pathSegment;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterPathSegment(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitPathSegment(this);
  }
}

class VariableContext extends ParserRuleContext {
  TerminalNode? NAME() => getToken(FirestoreRulesParser.TOKEN_NAME, 0);
  VariableContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_variable;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.enterVariable(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is FirestoreRulesListener) listener.exitVariable(this);
  }
}

