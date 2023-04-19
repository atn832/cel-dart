// Generated from CEL.g4 by ANTLR 4.11.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'dart:math';

import 'package:antlr4/antlr4.dart';
import 'package:cel/src/parser/bitwise.dart';

import 'CELListener.dart';
import 'CELBaseListener.dart';

const int RULE_start = 0,
    RULE_expr = 1,
    RULE_conditionalOr = 2,
    RULE_conditionalAnd = 3,
    RULE_relation = 4,
    RULE_calc = 5,
    RULE_unary = 6,
    RULE_member = 7,
    RULE_primary = 8,
    RULE_exprList = 9,
    RULE_listInit = 10,
    RULE_fieldInitializerList = 11,
    RULE_optField = 12,
    RULE_mapInitializerList = 13,
    RULE_optExpr = 14,
    RULE_literal = 15;

class CELParser extends Parser {
  static final checkVersion =
      () => RuntimeMetaData.checkVersion('4.11.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache =
      PredictionContextCache();
  static const int TOKEN_EQUALS = 1,
      TOKEN_NOT_EQUALS = 2,
      TOKEN_IN = 3,
      TOKEN_LESS = 4,
      TOKEN_LESS_EQUALS = 5,
      TOKEN_GREATER_EQUALS = 6,
      TOKEN_GREATER = 7,
      TOKEN_LOGICAL_AND = 8,
      TOKEN_LOGICAL_OR = 9,
      TOKEN_LBRACKET = 10,
      TOKEN_RPRACKET = 11,
      TOKEN_LBRACE = 12,
      TOKEN_RBRACE = 13,
      TOKEN_LPAREN = 14,
      TOKEN_RPAREN = 15,
      TOKEN_DOT = 16,
      TOKEN_COMMA = 17,
      TOKEN_MINUS = 18,
      TOKEN_EXCLAM = 19,
      TOKEN_QUESTIONMARK = 20,
      TOKEN_COLON = 21,
      TOKEN_PLUS = 22,
      TOKEN_STAR = 23,
      TOKEN_SLASH = 24,
      TOKEN_PERCENT = 25,
      TOKEN_CEL_TRUE = 26,
      TOKEN_CEL_FALSE = 27,
      TOKEN_NUL = 28,
      TOKEN_WHITESPACE = 29,
      TOKEN_COMMENT = 30,
      TOKEN_NUM_FLOAT = 31,
      TOKEN_NUM_INT = 32,
      TOKEN_NUM_UINT = 33,
      TOKEN_STRING = 34,
      TOKEN_BYTES = 35,
      TOKEN_IDENTIFIER = 36;

  @override
  final List<String> ruleNames = [
    'start',
    'expr',
    'conditionalOr',
    'conditionalAnd',
    'relation',
    'calc',
    'unary',
    'member',
    'primary',
    'exprList',
    'listInit',
    'fieldInitializerList',
    'optField',
    'mapInitializerList',
    'optExpr',
    'literal'
  ];

  static final List<String?> _LITERAL_NAMES = [
    null,
    "'=='",
    "'!='",
    "'in'",
    "'<'",
    "'<='",
    "'>='",
    "'>'",
    "'&&'",
    "'||'",
    "'['",
    "']'",
    "'{'",
    "'}'",
    "'('",
    "')'",
    "'.'",
    "','",
    "'-'",
    "'!'",
    "'?'",
    "':'",
    "'+'",
    "'*'",
    "'/'",
    "'%'",
    "'true'",
    "'false'",
    "'null'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
    null,
    "EQUALS",
    "NOT_EQUALS",
    "IN",
    "LESS",
    "LESS_EQUALS",
    "GREATER_EQUALS",
    "GREATER",
    "LOGICAL_AND",
    "LOGICAL_OR",
    "LBRACKET",
    "RPRACKET",
    "LBRACE",
    "RBRACE",
    "LPAREN",
    "RPAREN",
    "DOT",
    "COMMA",
    "MINUS",
    "EXCLAM",
    "QUESTIONMARK",
    "COLON",
    "PLUS",
    "STAR",
    "SLASH",
    "PERCENT",
    "CEL_TRUE",
    "CEL_FALSE",
    "NUL",
    "WHITESPACE",
    "COMMENT",
    "NUM_FLOAT",
    "NUM_INT",
    "NUM_UINT",
    "STRING",
    "BYTES",
    "IDENTIFIER"
  ];
  static final Vocabulary VOCABULARY =
      VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }

  @override
  String get grammarFileName => 'CEL.g4';

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  ATN getATN() {
    return _ATN;
  }

  CELParser(TokenStream input) : super(input) {
    interpreter =
        ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
  }

  StartContext start() {
    dynamic _localctx = StartContext(context, state);
    enterRule(_localctx, 0, RULE_start);
    try {
      enterOuterAlt(_localctx, 1);
      state = 32;
      _localctx.e = expr();
      state = 33;
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

  ExprContext expr() {
    dynamic _localctx = ExprContext(context, state);
    enterRule(_localctx, 2, RULE_expr);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 35;
      _localctx.e = conditionalOr();
      state = 41;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_QUESTIONMARK) {
        state = 36;
        _localctx.op = match(TOKEN_QUESTIONMARK);
        state = 37;
        _localctx.e1 = conditionalOr();
        state = 38;
        match(TOKEN_COLON);
        state = 39;
        _localctx.e2 = expr();
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

  ConditionalOrContext conditionalOr() {
    dynamic _localctx = ConditionalOrContext(context, state);
    enterRule(_localctx, 4, RULE_conditionalOr);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 43;
      _localctx.e = conditionalAnd();
      state = 48;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_LOGICAL_OR) {
        state = 44;
        _localctx.s9 = match(TOKEN_LOGICAL_OR);
        _localctx.ops.add(_localctx.s9);
        state = 45;
        _localctx._conditionalAnd = conditionalAnd();
        _localctx.e1.add(_localctx._conditionalAnd);
        state = 50;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
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

  ConditionalAndContext conditionalAnd() {
    dynamic _localctx = ConditionalAndContext(context, state);
    enterRule(_localctx, 6, RULE_conditionalAnd);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 51;
      _localctx.e = relation(0);
      state = 56;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_LOGICAL_AND) {
        state = 52;
        _localctx.s8 = match(TOKEN_LOGICAL_AND);
        _localctx.ops.add(_localctx.s8);
        state = 53;
        _localctx._relation = relation(0);
        _localctx.e1.add(_localctx._relation);
        state = 58;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
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

  RelationContext relation([int _p = 0]) {
    final _parentctx = context;
    final _parentState = state;
    dynamic _localctx = RelationContext(context, _parentState);
    var _prevctx = _localctx;
    var _startState = 8;
    enterRecursionRule(_localctx, 8, RULE_relation, _p);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 60;
      calc(0);
      context!.stop = tokenStream.LT(-1);
      state = 67;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 3, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          if (parseListeners != null) triggerExitRuleEvent();
          _prevctx = _localctx;
          _localctx = RelationContext(_parentctx, _parentState);
          pushNewRecursionContext(_localctx, _startState, RULE_relation);
          state = 62;
          if (!(precpred(context, 1))) {
            throw FailedPredicateException(this, "precpred(context, 1)");
          }
          state = 63;
          _localctx.op = tokenStream.LT(1);
          _la = tokenStream.LA(1)!;
          if (!(((_la) & ~0x3f) == 0 && bitwiseAnd(pow(2, _la), 254) != 0)) {
            _localctx.op = errorHandler.recoverInline(this);
          } else {
            if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
            errorHandler.reportMatch(this);
            consume();
          }
          state = 64;
          relation(2);
        }
        state = 69;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 3, context);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      unrollRecursionContexts(_parentctx);
    }
    return _localctx;
  }

  CalcContext calc([int _p = 0]) {
    final _parentctx = context;
    final _parentState = state;
    dynamic _localctx = CalcContext(context, _parentState);
    var _prevctx = _localctx;
    var _startState = 10;
    enterRecursionRule(_localctx, 10, RULE_calc, _p);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 71;
      unary();
      context!.stop = tokenStream.LT(-1);
      state = 81;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 5, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          if (parseListeners != null) triggerExitRuleEvent();
          _prevctx = _localctx;
          state = 79;
          errorHandler.sync(this);
          switch (interpreter!.adaptivePredict(tokenStream, 4, context)) {
            case 1:
              _localctx = CalcContext(_parentctx, _parentState);
              pushNewRecursionContext(_localctx, _startState, RULE_calc);
              state = 73;
              if (!(precpred(context, 2))) {
                throw FailedPredicateException(this, "precpred(context, 2)");
              }
              state = 74;
              _localctx.op = tokenStream.LT(1);
              _la = tokenStream.LA(1)!;
              if (!(((_la) & ~0x3f) == 0 &&
                  bitwiseAnd(pow(2, _la), 58720256) != 0)) {
                _localctx.op = errorHandler.recoverInline(this);
              } else {
                if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
                errorHandler.reportMatch(this);
                consume();
              }
              state = 75;
              calc(3);
              break;
            case 2:
              _localctx = CalcContext(_parentctx, _parentState);
              pushNewRecursionContext(_localctx, _startState, RULE_calc);
              state = 76;
              if (!(precpred(context, 1))) {
                throw FailedPredicateException(this, "precpred(context, 1)");
              }
              state = 77;
              _localctx.op = tokenStream.LT(1);
              _la = tokenStream.LA(1)!;
              if (!(_la == TOKEN_MINUS || _la == TOKEN_PLUS)) {
                _localctx.op = errorHandler.recoverInline(this);
              } else {
                if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
                errorHandler.reportMatch(this);
                consume();
              }
              state = 78;
              calc(2);
              break;
          }
        }
        state = 83;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 5, context);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      unrollRecursionContexts(_parentctx);
    }
    return _localctx;
  }

  UnaryContext unary() {
    dynamic _localctx = UnaryContext(context, state);
    enterRule(_localctx, 12, RULE_unary);
    int _la;
    try {
      int _alt;
      state = 97;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 8, context)) {
        case 1:
          _localctx = MemberExprContext(_localctx);
          enterOuterAlt(_localctx, 1);
          state = 84;
          member(0);
          break;
        case 2:
          _localctx = LogicalNotContext(_localctx);
          enterOuterAlt(_localctx, 2);
          state = 86;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          do {
            state = 85;
            _localctx.s19 = match(TOKEN_EXCLAM);
            _localctx.ops.add(_localctx.s19);
            state = 88;
            errorHandler.sync(this);
            _la = tokenStream.LA(1)!;
          } while (_la == TOKEN_EXCLAM);
          state = 90;
          member(0);
          break;
        case 3:
          _localctx = NegateContext(_localctx);
          enterOuterAlt(_localctx, 3);
          state = 92;
          errorHandler.sync(this);
          _alt = 1;
          do {
            switch (_alt) {
              case 1:
                state = 91;
                _localctx.s18 = match(TOKEN_MINUS);
                _localctx.ops.add(_localctx.s18);
                break;
              default:
                throw NoViableAltException(this);
            }
            state = 94;
            errorHandler.sync(this);
            _alt = interpreter!.adaptivePredict(tokenStream, 7, context);
          } while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER);
          state = 96;
          member(0);
          break;
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

  MemberContext member([int _p = 0]) {
    final _parentctx = context;
    final _parentState = state;
    dynamic _localctx = MemberContext(context, _parentState);
    var _prevctx = _localctx;
    var _startState = 14;
    enterRecursionRule(_localctx, 14, RULE_member, _p);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      _localctx = PrimaryExprContext(_localctx);
      context = _localctx;
      _prevctx = _localctx;

      state = 100;
      primary();
      context!.stop = tokenStream.LT(-1);
      state = 126;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 13, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          if (parseListeners != null) triggerExitRuleEvent();
          _prevctx = _localctx;
          state = 124;
          errorHandler.sync(this);
          switch (interpreter!.adaptivePredict(tokenStream, 12, context)) {
            case 1:
              _localctx =
                  SelectContext(new MemberContext(_parentctx, _parentState));
              pushNewRecursionContext(_localctx, _startState, RULE_member);
              state = 102;
              if (!(precpred(context, 3))) {
                throw FailedPredicateException(this, "precpred(context, 3)");
              }
              state = 103;
              _localctx.op = match(TOKEN_DOT);
              state = 105;
              errorHandler.sync(this);
              _la = tokenStream.LA(1)!;
              if (_la == TOKEN_QUESTIONMARK) {
                state = 104;
                _localctx.opt = match(TOKEN_QUESTIONMARK);
              }

              state = 107;
              _localctx.id = match(TOKEN_IDENTIFIER);
              break;
            case 2:
              _localctx = MemberCallContext(
                  new MemberContext(_parentctx, _parentState));
              pushNewRecursionContext(_localctx, _startState, RULE_member);
              state = 108;
              if (!(precpred(context, 2))) {
                throw FailedPredicateException(this, "precpred(context, 2)");
              }
              state = 109;
              _localctx.op = match(TOKEN_DOT);
              state = 110;
              _localctx.id = match(TOKEN_IDENTIFIER);
              state = 111;
              _localctx.open = match(TOKEN_LPAREN);
              state = 113;
              errorHandler.sync(this);
              _la = tokenStream.LA(1)!;
              if (((_la) & ~0x3f) == 0 &&
                  bitwiseAnd(pow(2, _la), 135762105344) != 0) {
                state = 112;
                _localctx.args = exprList();
              }

              state = 115;
              match(TOKEN_RPAREN);
              break;
            case 3:
              _localctx =
                  IndexContext(new MemberContext(_parentctx, _parentState));
              pushNewRecursionContext(_localctx, _startState, RULE_member);
              state = 116;
              if (!(precpred(context, 1))) {
                throw FailedPredicateException(this, "precpred(context, 1)");
              }
              state = 117;
              _localctx.op = match(TOKEN_LBRACKET);
              state = 119;
              errorHandler.sync(this);
              _la = tokenStream.LA(1)!;
              if (_la == TOKEN_QUESTIONMARK) {
                state = 118;
                _localctx.opt = match(TOKEN_QUESTIONMARK);
              }

              state = 121;
              _localctx.index = expr();
              state = 122;
              match(TOKEN_RPRACKET);
              break;
          }
        }
        state = 128;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 13, context);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      unrollRecursionContexts(_parentctx);
    }
    return _localctx;
  }

  PrimaryContext primary() {
    dynamic _localctx = PrimaryContext(context, state);
    enterRule(_localctx, 16, RULE_primary);
    int _la;
    try {
      state = 180;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 25, context)) {
        case 1:
          _localctx = IdentOrGlobalCallContext(_localctx);
          enterOuterAlt(_localctx, 1);
          state = 130;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_DOT) {
            state = 129;
            _localctx.leadingDot = match(TOKEN_DOT);
          }

          state = 132;
          _localctx.id = match(TOKEN_IDENTIFIER);
          state = 138;
          errorHandler.sync(this);
          switch (interpreter!.adaptivePredict(tokenStream, 16, context)) {
            case 1:
              state = 133;
              _localctx.op = match(TOKEN_LPAREN);
              state = 135;
              errorHandler.sync(this);
              _la = tokenStream.LA(1)!;
              if (((_la) & ~0x3f) == 0 &&
                  bitwiseAnd(pow(2, _la), 135762105344) != 0) {
                state = 134;
                _localctx.args = exprList();
              }

              state = 137;
              match(TOKEN_RPAREN);
              break;
          }
          break;
        case 2:
          _localctx = NestedContext(_localctx);
          enterOuterAlt(_localctx, 2);
          state = 140;
          match(TOKEN_LPAREN);
          state = 141;
          _localctx.e = expr();
          state = 142;
          match(TOKEN_RPAREN);
          break;
        case 3:
          _localctx = CreateListContext(_localctx);
          enterOuterAlt(_localctx, 3);
          state = 144;
          _localctx.op = match(TOKEN_LBRACKET);
          state = 146;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (((_la) & ~0x3f) == 0 &&
              bitwiseAnd(pow(2, _la), 135763153920) != 0) {
            state = 145;
            _localctx.elems = listInit();
          }

          state = 149;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_COMMA) {
            state = 148;
            match(TOKEN_COMMA);
          }

          state = 151;
          match(TOKEN_RPRACKET);
          break;
        case 4:
          _localctx = CreateStructContext(_localctx);
          enterOuterAlt(_localctx, 4);
          state = 152;
          _localctx.op = match(TOKEN_LBRACE);
          state = 154;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (((_la) & ~0x3f) == 0 &&
              bitwiseAnd(pow(2, _la), 135763153920) != 0) {
            state = 153;
            _localctx.entries = mapInitializerList();
          }

          state = 157;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_COMMA) {
            state = 156;
            match(TOKEN_COMMA);
          }

          state = 159;
          match(TOKEN_RBRACE);
          break;
        case 5:
          _localctx = CreateMessageContext(_localctx);
          enterOuterAlt(_localctx, 5);
          state = 161;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_DOT) {
            state = 160;
            _localctx.leadingDot = match(TOKEN_DOT);
          }

          state = 163;
          _localctx._IDENTIFIER = match(TOKEN_IDENTIFIER);
          _localctx.ids.add(_localctx._IDENTIFIER);
          state = 168;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          while (_la == TOKEN_DOT) {
            state = 164;
            _localctx.s16 = match(TOKEN_DOT);
            _localctx.ops.add(_localctx.s16);
            state = 165;
            _localctx._IDENTIFIER = match(TOKEN_IDENTIFIER);
            _localctx.ids.add(_localctx._IDENTIFIER);
            state = 170;
            errorHandler.sync(this);
            _la = tokenStream.LA(1)!;
          }
          state = 171;
          _localctx.op = match(TOKEN_LBRACE);
          state = 173;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_QUESTIONMARK || _la == TOKEN_IDENTIFIER) {
            state = 172;
            _localctx.entries = fieldInitializerList();
          }

          state = 176;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_COMMA) {
            state = 175;
            match(TOKEN_COMMA);
          }

          state = 178;
          match(TOKEN_RBRACE);
          break;
        case 6:
          _localctx = ConstantLiteralContext(_localctx);
          enterOuterAlt(_localctx, 6);
          state = 179;
          literal();
          break;
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

  ExprListContext exprList() {
    dynamic _localctx = ExprListContext(context, state);
    enterRule(_localctx, 18, RULE_exprList);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 182;
      _localctx._expr = expr();
      _localctx.e.add(_localctx._expr);
      state = 187;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_COMMA) {
        state = 183;
        match(TOKEN_COMMA);
        state = 184;
        _localctx._expr = expr();
        _localctx.e.add(_localctx._expr);
        state = 189;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
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

  ListInitContext listInit() {
    dynamic _localctx = ListInitContext(context, state);
    enterRule(_localctx, 20, RULE_listInit);
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 190;
      _localctx._optExpr = optExpr();
      _localctx.elems.add(_localctx._optExpr);
      state = 195;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 27, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 191;
          match(TOKEN_COMMA);
          state = 192;
          _localctx._optExpr = optExpr();
          _localctx.elems.add(_localctx._optExpr);
        }
        state = 197;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 27, context);
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

  FieldInitializerListContext fieldInitializerList() {
    dynamic _localctx = FieldInitializerListContext(context, state);
    enterRule(_localctx, 22, RULE_fieldInitializerList);
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 198;
      _localctx._optField = optField();
      _localctx.fields.add(_localctx._optField);
      state = 199;
      _localctx.s21 = match(TOKEN_COLON);
      _localctx.cols.add(_localctx.s21);
      state = 200;
      _localctx._expr = expr();
      _localctx.values.add(_localctx._expr);
      state = 208;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 28, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 201;
          match(TOKEN_COMMA);
          state = 202;
          _localctx._optField = optField();
          _localctx.fields.add(_localctx._optField);
          state = 203;
          _localctx.s21 = match(TOKEN_COLON);
          _localctx.cols.add(_localctx.s21);
          state = 204;
          _localctx._expr = expr();
          _localctx.values.add(_localctx._expr);
        }
        state = 210;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 28, context);
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

  OptFieldContext optField() {
    dynamic _localctx = OptFieldContext(context, state);
    enterRule(_localctx, 24, RULE_optField);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 212;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_QUESTIONMARK) {
        state = 211;
        _localctx.opt = match(TOKEN_QUESTIONMARK);
      }

      state = 214;
      match(TOKEN_IDENTIFIER);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  MapInitializerListContext mapInitializerList() {
    dynamic _localctx = MapInitializerListContext(context, state);
    enterRule(_localctx, 26, RULE_mapInitializerList);
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 216;
      _localctx._optExpr = optExpr();
      _localctx.keys.add(_localctx._optExpr);
      state = 217;
      _localctx.s21 = match(TOKEN_COLON);
      _localctx.cols.add(_localctx.s21);
      state = 218;
      _localctx._expr = expr();
      _localctx.values.add(_localctx._expr);
      state = 226;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 30, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 219;
          match(TOKEN_COMMA);
          state = 220;
          _localctx._optExpr = optExpr();
          _localctx.keys.add(_localctx._optExpr);
          state = 221;
          _localctx.s21 = match(TOKEN_COLON);
          _localctx.cols.add(_localctx.s21);
          state = 222;
          _localctx._expr = expr();
          _localctx.values.add(_localctx._expr);
        }
        state = 228;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 30, context);
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

  OptExprContext optExpr() {
    dynamic _localctx = OptExprContext(context, state);
    enterRule(_localctx, 28, RULE_optExpr);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 230;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_QUESTIONMARK) {
        state = 229;
        _localctx.opt = match(TOKEN_QUESTIONMARK);
      }

      state = 232;
      _localctx.e = expr();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  LiteralContext literal() {
    dynamic _localctx = LiteralContext(context, state);
    enterRule(_localctx, 30, RULE_literal);
    int _la;
    try {
      state = 248;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 34, context)) {
        case 1:
          _localctx = IntContext(_localctx);
          enterOuterAlt(_localctx, 1);
          state = 235;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_MINUS) {
            state = 234;
            _localctx.sign = match(TOKEN_MINUS);
          }

          state = 237;
          _localctx.tok = match(TOKEN_NUM_INT);
          break;
        case 2:
          _localctx = UintContext(_localctx);
          enterOuterAlt(_localctx, 2);
          state = 238;
          _localctx.tok = match(TOKEN_NUM_UINT);
          break;
        case 3:
          _localctx = DoubleContext(_localctx);
          enterOuterAlt(_localctx, 3);
          state = 240;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_MINUS) {
            state = 239;
            _localctx.sign = match(TOKEN_MINUS);
          }

          state = 242;
          _localctx.tok = match(TOKEN_NUM_FLOAT);
          break;
        case 4:
          _localctx = StringContext(_localctx);
          enterOuterAlt(_localctx, 4);
          state = 243;
          _localctx.tok = match(TOKEN_STRING);
          break;
        case 5:
          _localctx = BytesContext(_localctx);
          enterOuterAlt(_localctx, 5);
          state = 244;
          _localctx.tok = match(TOKEN_BYTES);
          break;
        case 6:
          _localctx = BoolTrueContext(_localctx);
          enterOuterAlt(_localctx, 6);
          state = 245;
          _localctx.tok = match(TOKEN_CEL_TRUE);
          break;
        case 7:
          _localctx = BoolFalseContext(_localctx);
          enterOuterAlt(_localctx, 7);
          state = 246;
          _localctx.tok = match(TOKEN_CEL_FALSE);
          break;
        case 8:
          _localctx = NullContext(_localctx);
          enterOuterAlt(_localctx, 8);
          state = 247;
          _localctx.tok = match(TOKEN_NUL);
          break;
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

  @override
  bool sempred(RuleContext? _localctx, int ruleIndex, int predIndex) {
    switch (ruleIndex) {
      case 4:
        return _relation_sempred(_localctx as RelationContext?, predIndex);
      case 5:
        return _calc_sempred(_localctx as CalcContext?, predIndex);
      case 7:
        return _member_sempred(_localctx as MemberContext?, predIndex);
    }
    return true;
  }

  bool _relation_sempred(dynamic _localctx, int predIndex) {
    switch (predIndex) {
      case 0:
        return precpred(context, 1);
    }
    return true;
  }

  bool _calc_sempred(dynamic _localctx, int predIndex) {
    switch (predIndex) {
      case 1:
        return precpred(context, 2);
      case 2:
        return precpred(context, 1);
    }
    return true;
  }

  bool _member_sempred(dynamic _localctx, int predIndex) {
    switch (predIndex) {
      case 3:
        return precpred(context, 3);
      case 4:
        return precpred(context, 2);
      case 5:
        return precpred(context, 1);
    }
    return true;
  }

  static const List<int> _serializedATN = [
    4,
    1,
    36,
    251,
    2,
    0,
    7,
    0,
    2,
    1,
    7,
    1,
    2,
    2,
    7,
    2,
    2,
    3,
    7,
    3,
    2,
    4,
    7,
    4,
    2,
    5,
    7,
    5,
    2,
    6,
    7,
    6,
    2,
    7,
    7,
    7,
    2,
    8,
    7,
    8,
    2,
    9,
    7,
    9,
    2,
    10,
    7,
    10,
    2,
    11,
    7,
    11,
    2,
    12,
    7,
    12,
    2,
    13,
    7,
    13,
    2,
    14,
    7,
    14,
    2,
    15,
    7,
    15,
    1,
    0,
    1,
    0,
    1,
    0,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    3,
    1,
    42,
    8,
    1,
    1,
    2,
    1,
    2,
    1,
    2,
    5,
    2,
    47,
    8,
    2,
    10,
    2,
    12,
    2,
    50,
    9,
    2,
    1,
    3,
    1,
    3,
    1,
    3,
    5,
    3,
    55,
    8,
    3,
    10,
    3,
    12,
    3,
    58,
    9,
    3,
    1,
    4,
    1,
    4,
    1,
    4,
    1,
    4,
    1,
    4,
    1,
    4,
    5,
    4,
    66,
    8,
    4,
    10,
    4,
    12,
    4,
    69,
    9,
    4,
    1,
    5,
    1,
    5,
    1,
    5,
    1,
    5,
    1,
    5,
    1,
    5,
    1,
    5,
    1,
    5,
    1,
    5,
    5,
    5,
    80,
    8,
    5,
    10,
    5,
    12,
    5,
    83,
    9,
    5,
    1,
    6,
    1,
    6,
    4,
    6,
    87,
    8,
    6,
    11,
    6,
    12,
    6,
    88,
    1,
    6,
    1,
    6,
    4,
    6,
    93,
    8,
    6,
    11,
    6,
    12,
    6,
    94,
    1,
    6,
    3,
    6,
    98,
    8,
    6,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    3,
    7,
    106,
    8,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    3,
    7,
    114,
    8,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    3,
    7,
    120,
    8,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    5,
    7,
    125,
    8,
    7,
    10,
    7,
    12,
    7,
    128,
    9,
    7,
    1,
    8,
    3,
    8,
    131,
    8,
    8,
    1,
    8,
    1,
    8,
    1,
    8,
    3,
    8,
    136,
    8,
    8,
    1,
    8,
    3,
    8,
    139,
    8,
    8,
    1,
    8,
    1,
    8,
    1,
    8,
    1,
    8,
    1,
    8,
    1,
    8,
    3,
    8,
    147,
    8,
    8,
    1,
    8,
    3,
    8,
    150,
    8,
    8,
    1,
    8,
    1,
    8,
    1,
    8,
    3,
    8,
    155,
    8,
    8,
    1,
    8,
    3,
    8,
    158,
    8,
    8,
    1,
    8,
    1,
    8,
    3,
    8,
    162,
    8,
    8,
    1,
    8,
    1,
    8,
    1,
    8,
    5,
    8,
    167,
    8,
    8,
    10,
    8,
    12,
    8,
    170,
    9,
    8,
    1,
    8,
    1,
    8,
    3,
    8,
    174,
    8,
    8,
    1,
    8,
    3,
    8,
    177,
    8,
    8,
    1,
    8,
    1,
    8,
    3,
    8,
    181,
    8,
    8,
    1,
    9,
    1,
    9,
    1,
    9,
    5,
    9,
    186,
    8,
    9,
    10,
    9,
    12,
    9,
    189,
    9,
    9,
    1,
    10,
    1,
    10,
    1,
    10,
    5,
    10,
    194,
    8,
    10,
    10,
    10,
    12,
    10,
    197,
    9,
    10,
    1,
    11,
    1,
    11,
    1,
    11,
    1,
    11,
    1,
    11,
    1,
    11,
    1,
    11,
    1,
    11,
    5,
    11,
    207,
    8,
    11,
    10,
    11,
    12,
    11,
    210,
    9,
    11,
    1,
    12,
    3,
    12,
    213,
    8,
    12,
    1,
    12,
    1,
    12,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    5,
    13,
    225,
    8,
    13,
    10,
    13,
    12,
    13,
    228,
    9,
    13,
    1,
    14,
    3,
    14,
    231,
    8,
    14,
    1,
    14,
    1,
    14,
    1,
    15,
    3,
    15,
    236,
    8,
    15,
    1,
    15,
    1,
    15,
    1,
    15,
    3,
    15,
    241,
    8,
    15,
    1,
    15,
    1,
    15,
    1,
    15,
    1,
    15,
    1,
    15,
    1,
    15,
    3,
    15,
    249,
    8,
    15,
    1,
    15,
    0,
    3,
    8,
    10,
    14,
    16,
    0,
    2,
    4,
    6,
    8,
    10,
    12,
    14,
    16,
    18,
    20,
    22,
    24,
    26,
    28,
    30,
    0,
    3,
    1,
    0,
    1,
    7,
    1,
    0,
    23,
    25,
    2,
    0,
    18,
    18,
    22,
    22,
    281,
    0,
    32,
    1,
    0,
    0,
    0,
    2,
    35,
    1,
    0,
    0,
    0,
    4,
    43,
    1,
    0,
    0,
    0,
    6,
    51,
    1,
    0,
    0,
    0,
    8,
    59,
    1,
    0,
    0,
    0,
    10,
    70,
    1,
    0,
    0,
    0,
    12,
    97,
    1,
    0,
    0,
    0,
    14,
    99,
    1,
    0,
    0,
    0,
    16,
    180,
    1,
    0,
    0,
    0,
    18,
    182,
    1,
    0,
    0,
    0,
    20,
    190,
    1,
    0,
    0,
    0,
    22,
    198,
    1,
    0,
    0,
    0,
    24,
    212,
    1,
    0,
    0,
    0,
    26,
    216,
    1,
    0,
    0,
    0,
    28,
    230,
    1,
    0,
    0,
    0,
    30,
    248,
    1,
    0,
    0,
    0,
    32,
    33,
    3,
    2,
    1,
    0,
    33,
    34,
    5,
    0,
    0,
    1,
    34,
    1,
    1,
    0,
    0,
    0,
    35,
    41,
    3,
    4,
    2,
    0,
    36,
    37,
    5,
    20,
    0,
    0,
    37,
    38,
    3,
    4,
    2,
    0,
    38,
    39,
    5,
    21,
    0,
    0,
    39,
    40,
    3,
    2,
    1,
    0,
    40,
    42,
    1,
    0,
    0,
    0,
    41,
    36,
    1,
    0,
    0,
    0,
    41,
    42,
    1,
    0,
    0,
    0,
    42,
    3,
    1,
    0,
    0,
    0,
    43,
    48,
    3,
    6,
    3,
    0,
    44,
    45,
    5,
    9,
    0,
    0,
    45,
    47,
    3,
    6,
    3,
    0,
    46,
    44,
    1,
    0,
    0,
    0,
    47,
    50,
    1,
    0,
    0,
    0,
    48,
    46,
    1,
    0,
    0,
    0,
    48,
    49,
    1,
    0,
    0,
    0,
    49,
    5,
    1,
    0,
    0,
    0,
    50,
    48,
    1,
    0,
    0,
    0,
    51,
    56,
    3,
    8,
    4,
    0,
    52,
    53,
    5,
    8,
    0,
    0,
    53,
    55,
    3,
    8,
    4,
    0,
    54,
    52,
    1,
    0,
    0,
    0,
    55,
    58,
    1,
    0,
    0,
    0,
    56,
    54,
    1,
    0,
    0,
    0,
    56,
    57,
    1,
    0,
    0,
    0,
    57,
    7,
    1,
    0,
    0,
    0,
    58,
    56,
    1,
    0,
    0,
    0,
    59,
    60,
    6,
    4,
    -1,
    0,
    60,
    61,
    3,
    10,
    5,
    0,
    61,
    67,
    1,
    0,
    0,
    0,
    62,
    63,
    10,
    1,
    0,
    0,
    63,
    64,
    7,
    0,
    0,
    0,
    64,
    66,
    3,
    8,
    4,
    2,
    65,
    62,
    1,
    0,
    0,
    0,
    66,
    69,
    1,
    0,
    0,
    0,
    67,
    65,
    1,
    0,
    0,
    0,
    67,
    68,
    1,
    0,
    0,
    0,
    68,
    9,
    1,
    0,
    0,
    0,
    69,
    67,
    1,
    0,
    0,
    0,
    70,
    71,
    6,
    5,
    -1,
    0,
    71,
    72,
    3,
    12,
    6,
    0,
    72,
    81,
    1,
    0,
    0,
    0,
    73,
    74,
    10,
    2,
    0,
    0,
    74,
    75,
    7,
    1,
    0,
    0,
    75,
    80,
    3,
    10,
    5,
    3,
    76,
    77,
    10,
    1,
    0,
    0,
    77,
    78,
    7,
    2,
    0,
    0,
    78,
    80,
    3,
    10,
    5,
    2,
    79,
    73,
    1,
    0,
    0,
    0,
    79,
    76,
    1,
    0,
    0,
    0,
    80,
    83,
    1,
    0,
    0,
    0,
    81,
    79,
    1,
    0,
    0,
    0,
    81,
    82,
    1,
    0,
    0,
    0,
    82,
    11,
    1,
    0,
    0,
    0,
    83,
    81,
    1,
    0,
    0,
    0,
    84,
    98,
    3,
    14,
    7,
    0,
    85,
    87,
    5,
    19,
    0,
    0,
    86,
    85,
    1,
    0,
    0,
    0,
    87,
    88,
    1,
    0,
    0,
    0,
    88,
    86,
    1,
    0,
    0,
    0,
    88,
    89,
    1,
    0,
    0,
    0,
    89,
    90,
    1,
    0,
    0,
    0,
    90,
    98,
    3,
    14,
    7,
    0,
    91,
    93,
    5,
    18,
    0,
    0,
    92,
    91,
    1,
    0,
    0,
    0,
    93,
    94,
    1,
    0,
    0,
    0,
    94,
    92,
    1,
    0,
    0,
    0,
    94,
    95,
    1,
    0,
    0,
    0,
    95,
    96,
    1,
    0,
    0,
    0,
    96,
    98,
    3,
    14,
    7,
    0,
    97,
    84,
    1,
    0,
    0,
    0,
    97,
    86,
    1,
    0,
    0,
    0,
    97,
    92,
    1,
    0,
    0,
    0,
    98,
    13,
    1,
    0,
    0,
    0,
    99,
    100,
    6,
    7,
    -1,
    0,
    100,
    101,
    3,
    16,
    8,
    0,
    101,
    126,
    1,
    0,
    0,
    0,
    102,
    103,
    10,
    3,
    0,
    0,
    103,
    105,
    5,
    16,
    0,
    0,
    104,
    106,
    5,
    20,
    0,
    0,
    105,
    104,
    1,
    0,
    0,
    0,
    105,
    106,
    1,
    0,
    0,
    0,
    106,
    107,
    1,
    0,
    0,
    0,
    107,
    125,
    5,
    36,
    0,
    0,
    108,
    109,
    10,
    2,
    0,
    0,
    109,
    110,
    5,
    16,
    0,
    0,
    110,
    111,
    5,
    36,
    0,
    0,
    111,
    113,
    5,
    14,
    0,
    0,
    112,
    114,
    3,
    18,
    9,
    0,
    113,
    112,
    1,
    0,
    0,
    0,
    113,
    114,
    1,
    0,
    0,
    0,
    114,
    115,
    1,
    0,
    0,
    0,
    115,
    125,
    5,
    15,
    0,
    0,
    116,
    117,
    10,
    1,
    0,
    0,
    117,
    119,
    5,
    10,
    0,
    0,
    118,
    120,
    5,
    20,
    0,
    0,
    119,
    118,
    1,
    0,
    0,
    0,
    119,
    120,
    1,
    0,
    0,
    0,
    120,
    121,
    1,
    0,
    0,
    0,
    121,
    122,
    3,
    2,
    1,
    0,
    122,
    123,
    5,
    11,
    0,
    0,
    123,
    125,
    1,
    0,
    0,
    0,
    124,
    102,
    1,
    0,
    0,
    0,
    124,
    108,
    1,
    0,
    0,
    0,
    124,
    116,
    1,
    0,
    0,
    0,
    125,
    128,
    1,
    0,
    0,
    0,
    126,
    124,
    1,
    0,
    0,
    0,
    126,
    127,
    1,
    0,
    0,
    0,
    127,
    15,
    1,
    0,
    0,
    0,
    128,
    126,
    1,
    0,
    0,
    0,
    129,
    131,
    5,
    16,
    0,
    0,
    130,
    129,
    1,
    0,
    0,
    0,
    130,
    131,
    1,
    0,
    0,
    0,
    131,
    132,
    1,
    0,
    0,
    0,
    132,
    138,
    5,
    36,
    0,
    0,
    133,
    135,
    5,
    14,
    0,
    0,
    134,
    136,
    3,
    18,
    9,
    0,
    135,
    134,
    1,
    0,
    0,
    0,
    135,
    136,
    1,
    0,
    0,
    0,
    136,
    137,
    1,
    0,
    0,
    0,
    137,
    139,
    5,
    15,
    0,
    0,
    138,
    133,
    1,
    0,
    0,
    0,
    138,
    139,
    1,
    0,
    0,
    0,
    139,
    181,
    1,
    0,
    0,
    0,
    140,
    141,
    5,
    14,
    0,
    0,
    141,
    142,
    3,
    2,
    1,
    0,
    142,
    143,
    5,
    15,
    0,
    0,
    143,
    181,
    1,
    0,
    0,
    0,
    144,
    146,
    5,
    10,
    0,
    0,
    145,
    147,
    3,
    20,
    10,
    0,
    146,
    145,
    1,
    0,
    0,
    0,
    146,
    147,
    1,
    0,
    0,
    0,
    147,
    149,
    1,
    0,
    0,
    0,
    148,
    150,
    5,
    17,
    0,
    0,
    149,
    148,
    1,
    0,
    0,
    0,
    149,
    150,
    1,
    0,
    0,
    0,
    150,
    151,
    1,
    0,
    0,
    0,
    151,
    181,
    5,
    11,
    0,
    0,
    152,
    154,
    5,
    12,
    0,
    0,
    153,
    155,
    3,
    26,
    13,
    0,
    154,
    153,
    1,
    0,
    0,
    0,
    154,
    155,
    1,
    0,
    0,
    0,
    155,
    157,
    1,
    0,
    0,
    0,
    156,
    158,
    5,
    17,
    0,
    0,
    157,
    156,
    1,
    0,
    0,
    0,
    157,
    158,
    1,
    0,
    0,
    0,
    158,
    159,
    1,
    0,
    0,
    0,
    159,
    181,
    5,
    13,
    0,
    0,
    160,
    162,
    5,
    16,
    0,
    0,
    161,
    160,
    1,
    0,
    0,
    0,
    161,
    162,
    1,
    0,
    0,
    0,
    162,
    163,
    1,
    0,
    0,
    0,
    163,
    168,
    5,
    36,
    0,
    0,
    164,
    165,
    5,
    16,
    0,
    0,
    165,
    167,
    5,
    36,
    0,
    0,
    166,
    164,
    1,
    0,
    0,
    0,
    167,
    170,
    1,
    0,
    0,
    0,
    168,
    166,
    1,
    0,
    0,
    0,
    168,
    169,
    1,
    0,
    0,
    0,
    169,
    171,
    1,
    0,
    0,
    0,
    170,
    168,
    1,
    0,
    0,
    0,
    171,
    173,
    5,
    12,
    0,
    0,
    172,
    174,
    3,
    22,
    11,
    0,
    173,
    172,
    1,
    0,
    0,
    0,
    173,
    174,
    1,
    0,
    0,
    0,
    174,
    176,
    1,
    0,
    0,
    0,
    175,
    177,
    5,
    17,
    0,
    0,
    176,
    175,
    1,
    0,
    0,
    0,
    176,
    177,
    1,
    0,
    0,
    0,
    177,
    178,
    1,
    0,
    0,
    0,
    178,
    181,
    5,
    13,
    0,
    0,
    179,
    181,
    3,
    30,
    15,
    0,
    180,
    130,
    1,
    0,
    0,
    0,
    180,
    140,
    1,
    0,
    0,
    0,
    180,
    144,
    1,
    0,
    0,
    0,
    180,
    152,
    1,
    0,
    0,
    0,
    180,
    161,
    1,
    0,
    0,
    0,
    180,
    179,
    1,
    0,
    0,
    0,
    181,
    17,
    1,
    0,
    0,
    0,
    182,
    187,
    3,
    2,
    1,
    0,
    183,
    184,
    5,
    17,
    0,
    0,
    184,
    186,
    3,
    2,
    1,
    0,
    185,
    183,
    1,
    0,
    0,
    0,
    186,
    189,
    1,
    0,
    0,
    0,
    187,
    185,
    1,
    0,
    0,
    0,
    187,
    188,
    1,
    0,
    0,
    0,
    188,
    19,
    1,
    0,
    0,
    0,
    189,
    187,
    1,
    0,
    0,
    0,
    190,
    195,
    3,
    28,
    14,
    0,
    191,
    192,
    5,
    17,
    0,
    0,
    192,
    194,
    3,
    28,
    14,
    0,
    193,
    191,
    1,
    0,
    0,
    0,
    194,
    197,
    1,
    0,
    0,
    0,
    195,
    193,
    1,
    0,
    0,
    0,
    195,
    196,
    1,
    0,
    0,
    0,
    196,
    21,
    1,
    0,
    0,
    0,
    197,
    195,
    1,
    0,
    0,
    0,
    198,
    199,
    3,
    24,
    12,
    0,
    199,
    200,
    5,
    21,
    0,
    0,
    200,
    208,
    3,
    2,
    1,
    0,
    201,
    202,
    5,
    17,
    0,
    0,
    202,
    203,
    3,
    24,
    12,
    0,
    203,
    204,
    5,
    21,
    0,
    0,
    204,
    205,
    3,
    2,
    1,
    0,
    205,
    207,
    1,
    0,
    0,
    0,
    206,
    201,
    1,
    0,
    0,
    0,
    207,
    210,
    1,
    0,
    0,
    0,
    208,
    206,
    1,
    0,
    0,
    0,
    208,
    209,
    1,
    0,
    0,
    0,
    209,
    23,
    1,
    0,
    0,
    0,
    210,
    208,
    1,
    0,
    0,
    0,
    211,
    213,
    5,
    20,
    0,
    0,
    212,
    211,
    1,
    0,
    0,
    0,
    212,
    213,
    1,
    0,
    0,
    0,
    213,
    214,
    1,
    0,
    0,
    0,
    214,
    215,
    5,
    36,
    0,
    0,
    215,
    25,
    1,
    0,
    0,
    0,
    216,
    217,
    3,
    28,
    14,
    0,
    217,
    218,
    5,
    21,
    0,
    0,
    218,
    226,
    3,
    2,
    1,
    0,
    219,
    220,
    5,
    17,
    0,
    0,
    220,
    221,
    3,
    28,
    14,
    0,
    221,
    222,
    5,
    21,
    0,
    0,
    222,
    223,
    3,
    2,
    1,
    0,
    223,
    225,
    1,
    0,
    0,
    0,
    224,
    219,
    1,
    0,
    0,
    0,
    225,
    228,
    1,
    0,
    0,
    0,
    226,
    224,
    1,
    0,
    0,
    0,
    226,
    227,
    1,
    0,
    0,
    0,
    227,
    27,
    1,
    0,
    0,
    0,
    228,
    226,
    1,
    0,
    0,
    0,
    229,
    231,
    5,
    20,
    0,
    0,
    230,
    229,
    1,
    0,
    0,
    0,
    230,
    231,
    1,
    0,
    0,
    0,
    231,
    232,
    1,
    0,
    0,
    0,
    232,
    233,
    3,
    2,
    1,
    0,
    233,
    29,
    1,
    0,
    0,
    0,
    234,
    236,
    5,
    18,
    0,
    0,
    235,
    234,
    1,
    0,
    0,
    0,
    235,
    236,
    1,
    0,
    0,
    0,
    236,
    237,
    1,
    0,
    0,
    0,
    237,
    249,
    5,
    32,
    0,
    0,
    238,
    249,
    5,
    33,
    0,
    0,
    239,
    241,
    5,
    18,
    0,
    0,
    240,
    239,
    1,
    0,
    0,
    0,
    240,
    241,
    1,
    0,
    0,
    0,
    241,
    242,
    1,
    0,
    0,
    0,
    242,
    249,
    5,
    31,
    0,
    0,
    243,
    249,
    5,
    34,
    0,
    0,
    244,
    249,
    5,
    35,
    0,
    0,
    245,
    249,
    5,
    26,
    0,
    0,
    246,
    249,
    5,
    27,
    0,
    0,
    247,
    249,
    5,
    28,
    0,
    0,
    248,
    235,
    1,
    0,
    0,
    0,
    248,
    238,
    1,
    0,
    0,
    0,
    248,
    240,
    1,
    0,
    0,
    0,
    248,
    243,
    1,
    0,
    0,
    0,
    248,
    244,
    1,
    0,
    0,
    0,
    248,
    245,
    1,
    0,
    0,
    0,
    248,
    246,
    1,
    0,
    0,
    0,
    248,
    247,
    1,
    0,
    0,
    0,
    249,
    31,
    1,
    0,
    0,
    0,
    35,
    41,
    48,
    56,
    67,
    79,
    81,
    88,
    94,
    97,
    105,
    113,
    119,
    124,
    126,
    130,
    135,
    138,
    146,
    149,
    154,
    157,
    161,
    168,
    173,
    176,
    180,
    187,
    195,
    208,
    212,
    226,
    230,
    235,
    240,
    248
  ];

  static final ATN _ATN = ATNDeserializer().deserialize(_serializedATN);
}

class StartContext extends ParserRuleContext {
  ExprContext? e;
  TerminalNode? EOF() => getToken(CELParser.TOKEN_EOF, 0);
  ExprContext? expr() => getRuleContext<ExprContext>(0);
  StartContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_start;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterStart(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitStart(this);
  }
}

class ExprContext extends ParserRuleContext {
  ConditionalOrContext? e;
  Token? op;
  ConditionalOrContext? e1;
  ExprContext? e2;
  List<ConditionalOrContext> conditionalOrs() =>
      getRuleContexts<ConditionalOrContext>();
  ConditionalOrContext? conditionalOr(int i) =>
      getRuleContext<ConditionalOrContext>(i);
  TerminalNode? COLON() => getToken(CELParser.TOKEN_COLON, 0);
  TerminalNode? QUESTIONMARK() => getToken(CELParser.TOKEN_QUESTIONMARK, 0);
  ExprContext? expr() => getRuleContext<ExprContext>(0);
  ExprContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_expr;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterExpr(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitExpr(this);
  }
}

class ConditionalOrContext extends ParserRuleContext {
  ConditionalAndContext? e;
  Token? s9;
  var ops = <Token>[];
  ConditionalAndContext? _conditionalAnd;
  var e1 = <ConditionalAndContext>[];
  List<ConditionalAndContext> conditionalAnds() =>
      getRuleContexts<ConditionalAndContext>();
  ConditionalAndContext? conditionalAnd(int i) =>
      getRuleContext<ConditionalAndContext>(i);
  List<TerminalNode> LOGICAL_ORs() => getTokens(CELParser.TOKEN_LOGICAL_OR);
  TerminalNode? LOGICAL_OR(int i) => getToken(CELParser.TOKEN_LOGICAL_OR, i);
  ConditionalOrContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_conditionalOr;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterConditionalOr(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitConditionalOr(this);
  }
}

class ConditionalAndContext extends ParserRuleContext {
  RelationContext? e;
  Token? s8;
  var ops = <Token>[];
  RelationContext? _relation;
  var e1 = <RelationContext>[];
  List<RelationContext> relations() => getRuleContexts<RelationContext>();
  RelationContext? relation(int i) => getRuleContext<RelationContext>(i);
  List<TerminalNode> LOGICAL_ANDs() => getTokens(CELParser.TOKEN_LOGICAL_AND);
  TerminalNode? LOGICAL_AND(int i) => getToken(CELParser.TOKEN_LOGICAL_AND, i);
  ConditionalAndContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_conditionalAnd;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterConditionalAnd(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitConditionalAnd(this);
  }
}

class RelationContext extends ParserRuleContext {
  Token? op;
  CalcContext? calc() => getRuleContext<CalcContext>(0);
  List<RelationContext> relations() => getRuleContexts<RelationContext>();
  RelationContext? relation(int i) => getRuleContext<RelationContext>(i);
  TerminalNode? LESS() => getToken(CELParser.TOKEN_LESS, 0);
  TerminalNode? LESS_EQUALS() => getToken(CELParser.TOKEN_LESS_EQUALS, 0);
  TerminalNode? GREATER_EQUALS() => getToken(CELParser.TOKEN_GREATER_EQUALS, 0);
  TerminalNode? GREATER() => getToken(CELParser.TOKEN_GREATER, 0);
  TerminalNode? EQUALS() => getToken(CELParser.TOKEN_EQUALS, 0);
  TerminalNode? NOT_EQUALS() => getToken(CELParser.TOKEN_NOT_EQUALS, 0);
  TerminalNode? IN() => getToken(CELParser.TOKEN_IN, 0);
  RelationContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_relation;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterRelation(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitRelation(this);
  }
}

class CalcContext extends ParserRuleContext {
  Token? op;
  UnaryContext? unary() => getRuleContext<UnaryContext>(0);
  List<CalcContext> calcs() => getRuleContexts<CalcContext>();
  CalcContext? calc(int i) => getRuleContext<CalcContext>(i);
  TerminalNode? STAR() => getToken(CELParser.TOKEN_STAR, 0);
  TerminalNode? SLASH() => getToken(CELParser.TOKEN_SLASH, 0);
  TerminalNode? PERCENT() => getToken(CELParser.TOKEN_PERCENT, 0);
  TerminalNode? PLUS() => getToken(CELParser.TOKEN_PLUS, 0);
  TerminalNode? MINUS() => getToken(CELParser.TOKEN_MINUS, 0);
  CalcContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_calc;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterCalc(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitCalc(this);
  }
}

class UnaryContext extends ParserRuleContext {
  UnaryContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_unary;

  @override
  void copyFrom(ParserRuleContext ctx) {
    super.copyFrom(ctx);
  }
}

class MemberContext extends ParserRuleContext {
  MemberContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_member;

  @override
  void copyFrom(ParserRuleContext ctx) {
    super.copyFrom(ctx);
  }
}

class PrimaryContext extends ParserRuleContext {
  PrimaryContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_primary;

  @override
  void copyFrom(ParserRuleContext ctx) {
    super.copyFrom(ctx);
  }
}

class ExprListContext extends ParserRuleContext {
  ExprContext? _expr;
  var e = <ExprContext>[];
  List<ExprContext> exprs() => getRuleContexts<ExprContext>();
  ExprContext? expr(int i) => getRuleContext<ExprContext>(i);
  List<TerminalNode> COMMAs() => getTokens(CELParser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(CELParser.TOKEN_COMMA, i);
  ExprListContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_exprList;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterExprList(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitExprList(this);
  }
}

class ListInitContext extends ParserRuleContext {
  OptExprContext? _optExpr;
  var elems = <OptExprContext>[];
  List<OptExprContext> optExprs() => getRuleContexts<OptExprContext>();
  OptExprContext? optExpr(int i) => getRuleContext<OptExprContext>(i);
  List<TerminalNode> COMMAs() => getTokens(CELParser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(CELParser.TOKEN_COMMA, i);
  ListInitContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_listInit;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterListInit(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitListInit(this);
  }
}

class FieldInitializerListContext extends ParserRuleContext {
  OptFieldContext? _optField;
  var fields = <OptFieldContext>[];
  Token? s21;
  var cols = <Token>[];
  ExprContext? _expr;
  var values = <ExprContext>[];
  List<OptFieldContext> optFields() => getRuleContexts<OptFieldContext>();
  OptFieldContext? optField(int i) => getRuleContext<OptFieldContext>(i);
  List<TerminalNode> COLONs() => getTokens(CELParser.TOKEN_COLON);
  TerminalNode? COLON(int i) => getToken(CELParser.TOKEN_COLON, i);
  List<ExprContext> exprs() => getRuleContexts<ExprContext>();
  ExprContext? expr(int i) => getRuleContext<ExprContext>(i);
  List<TerminalNode> COMMAs() => getTokens(CELParser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(CELParser.TOKEN_COMMA, i);
  FieldInitializerListContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_fieldInitializerList;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterFieldInitializerList(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitFieldInitializerList(this);
  }
}

class OptFieldContext extends ParserRuleContext {
  Token? opt;
  TerminalNode? IDENTIFIER() => getToken(CELParser.TOKEN_IDENTIFIER, 0);
  TerminalNode? QUESTIONMARK() => getToken(CELParser.TOKEN_QUESTIONMARK, 0);
  OptFieldContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_optField;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterOptField(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitOptField(this);
  }
}

class MapInitializerListContext extends ParserRuleContext {
  OptExprContext? _optExpr;
  var keys = <OptExprContext>[];
  Token? s21;
  var cols = <Token>[];
  ExprContext? _expr;
  var values = <ExprContext>[];
  List<OptExprContext> optExprs() => getRuleContexts<OptExprContext>();
  OptExprContext? optExpr(int i) => getRuleContext<OptExprContext>(i);
  List<TerminalNode> COLONs() => getTokens(CELParser.TOKEN_COLON);
  TerminalNode? COLON(int i) => getToken(CELParser.TOKEN_COLON, i);
  List<ExprContext> exprs() => getRuleContexts<ExprContext>();
  ExprContext? expr(int i) => getRuleContext<ExprContext>(i);
  List<TerminalNode> COMMAs() => getTokens(CELParser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(CELParser.TOKEN_COMMA, i);
  MapInitializerListContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_mapInitializerList;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterMapInitializerList(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitMapInitializerList(this);
  }
}

class OptExprContext extends ParserRuleContext {
  Token? opt;
  ExprContext? e;
  ExprContext? expr() => getRuleContext<ExprContext>(0);
  TerminalNode? QUESTIONMARK() => getToken(CELParser.TOKEN_QUESTIONMARK, 0);
  OptExprContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_optExpr;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterOptExpr(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitOptExpr(this);
  }
}

class LiteralContext extends ParserRuleContext {
  LiteralContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_literal;

  @override
  void copyFrom(ParserRuleContext ctx) {
    super.copyFrom(ctx);
  }
}

class LogicalNotContext extends UnaryContext {
  Token? s19;
  var ops = <Token>[];
  MemberContext? member() => getRuleContext<MemberContext>(0);
  List<TerminalNode> EXCLAMs() => getTokens(CELParser.TOKEN_EXCLAM);
  TerminalNode? EXCLAM(int i) => getToken(CELParser.TOKEN_EXCLAM, i);
  LogicalNotContext(UnaryContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterLogicalNot(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitLogicalNot(this);
  }
}

class MemberExprContext extends UnaryContext {
  MemberContext? member() => getRuleContext<MemberContext>(0);
  MemberExprContext(UnaryContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterMemberExpr(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitMemberExpr(this);
  }
}

class NegateContext extends UnaryContext {
  Token? s18;
  var ops = <Token>[];
  MemberContext? member() => getRuleContext<MemberContext>(0);
  List<TerminalNode> MINUSs() => getTokens(CELParser.TOKEN_MINUS);
  TerminalNode? MINUS(int i) => getToken(CELParser.TOKEN_MINUS, i);
  NegateContext(UnaryContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterNegate(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitNegate(this);
  }
}

class MemberCallContext extends MemberContext {
  Token? op;
  Token? id;
  Token? open;
  ExprListContext? args;
  MemberContext? member() => getRuleContext<MemberContext>(0);
  TerminalNode? RPAREN() => getToken(CELParser.TOKEN_RPAREN, 0);
  TerminalNode? DOT() => getToken(CELParser.TOKEN_DOT, 0);
  TerminalNode? IDENTIFIER() => getToken(CELParser.TOKEN_IDENTIFIER, 0);
  TerminalNode? LPAREN() => getToken(CELParser.TOKEN_LPAREN, 0);
  ExprListContext? exprList() => getRuleContext<ExprListContext>(0);
  MemberCallContext(MemberContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterMemberCall(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitMemberCall(this);
  }
}

class SelectContext extends MemberContext {
  Token? op;
  Token? opt;
  Token? id;
  MemberContext? member() => getRuleContext<MemberContext>(0);
  TerminalNode? DOT() => getToken(CELParser.TOKEN_DOT, 0);
  TerminalNode? IDENTIFIER() => getToken(CELParser.TOKEN_IDENTIFIER, 0);
  TerminalNode? QUESTIONMARK() => getToken(CELParser.TOKEN_QUESTIONMARK, 0);
  SelectContext(MemberContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterSelect(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitSelect(this);
  }
}

class PrimaryExprContext extends MemberContext {
  PrimaryContext? primary() => getRuleContext<PrimaryContext>(0);
  PrimaryExprContext(MemberContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterPrimaryExpr(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitPrimaryExpr(this);
  }
}

class IndexContext extends MemberContext {
  Token? op;
  Token? opt;
  ExprContext? index;
  MemberContext? member() => getRuleContext<MemberContext>(0);
  TerminalNode? RPRACKET() => getToken(CELParser.TOKEN_RPRACKET, 0);
  TerminalNode? LBRACKET() => getToken(CELParser.TOKEN_LBRACKET, 0);
  ExprContext? expr() => getRuleContext<ExprContext>(0);
  TerminalNode? QUESTIONMARK() => getToken(CELParser.TOKEN_QUESTIONMARK, 0);
  IndexContext(MemberContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterIndex(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitIndex(this);
  }
}

class CreateListContext extends PrimaryContext {
  Token? op;
  ListInitContext? elems;
  TerminalNode? RPRACKET() => getToken(CELParser.TOKEN_RPRACKET, 0);
  TerminalNode? LBRACKET() => getToken(CELParser.TOKEN_LBRACKET, 0);
  TerminalNode? COMMA() => getToken(CELParser.TOKEN_COMMA, 0);
  ListInitContext? listInit() => getRuleContext<ListInitContext>(0);
  CreateListContext(PrimaryContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterCreateList(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitCreateList(this);
  }
}

class CreateStructContext extends PrimaryContext {
  Token? op;
  MapInitializerListContext? entries;
  TerminalNode? RBRACE() => getToken(CELParser.TOKEN_RBRACE, 0);
  TerminalNode? LBRACE() => getToken(CELParser.TOKEN_LBRACE, 0);
  TerminalNode? COMMA() => getToken(CELParser.TOKEN_COMMA, 0);
  MapInitializerListContext? mapInitializerList() =>
      getRuleContext<MapInitializerListContext>(0);
  CreateStructContext(PrimaryContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterCreateStruct(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitCreateStruct(this);
  }
}

class ConstantLiteralContext extends PrimaryContext {
  LiteralContext? literal() => getRuleContext<LiteralContext>(0);
  ConstantLiteralContext(PrimaryContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterConstantLiteral(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitConstantLiteral(this);
  }
}

class NestedContext extends PrimaryContext {
  ExprContext? e;
  TerminalNode? LPAREN() => getToken(CELParser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(CELParser.TOKEN_RPAREN, 0);
  ExprContext? expr() => getRuleContext<ExprContext>(0);
  NestedContext(PrimaryContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterNested(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitNested(this);
  }
}

class CreateMessageContext extends PrimaryContext {
  Token? leadingDot;
  Token? _IDENTIFIER;
  var ids = <Token>[];
  Token? s16;
  var ops = <Token>[];
  Token? op;
  FieldInitializerListContext? entries;
  TerminalNode? RBRACE() => getToken(CELParser.TOKEN_RBRACE, 0);
  List<TerminalNode> IDENTIFIERs() => getTokens(CELParser.TOKEN_IDENTIFIER);
  TerminalNode? IDENTIFIER(int i) => getToken(CELParser.TOKEN_IDENTIFIER, i);
  TerminalNode? LBRACE() => getToken(CELParser.TOKEN_LBRACE, 0);
  TerminalNode? COMMA() => getToken(CELParser.TOKEN_COMMA, 0);
  List<TerminalNode> DOTs() => getTokens(CELParser.TOKEN_DOT);
  TerminalNode? DOT(int i) => getToken(CELParser.TOKEN_DOT, i);
  FieldInitializerListContext? fieldInitializerList() =>
      getRuleContext<FieldInitializerListContext>(0);
  CreateMessageContext(PrimaryContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterCreateMessage(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitCreateMessage(this);
  }
}

class IdentOrGlobalCallContext extends PrimaryContext {
  Token? leadingDot;
  Token? id;
  Token? op;
  ExprListContext? args;
  TerminalNode? IDENTIFIER() => getToken(CELParser.TOKEN_IDENTIFIER, 0);
  TerminalNode? RPAREN() => getToken(CELParser.TOKEN_RPAREN, 0);
  TerminalNode? DOT() => getToken(CELParser.TOKEN_DOT, 0);
  TerminalNode? LPAREN() => getToken(CELParser.TOKEN_LPAREN, 0);
  ExprListContext? exprList() => getRuleContext<ExprListContext>(0);
  IdentOrGlobalCallContext(PrimaryContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterIdentOrGlobalCall(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitIdentOrGlobalCall(this);
  }
}

class BytesContext extends LiteralContext {
  Token? tok;
  TerminalNode? BYTES() => getToken(CELParser.TOKEN_BYTES, 0);
  BytesContext(LiteralContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterBytes(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitBytes(this);
  }
}

class UintContext extends LiteralContext {
  Token? tok;
  TerminalNode? NUM_UINT() => getToken(CELParser.TOKEN_NUM_UINT, 0);
  UintContext(LiteralContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterUint(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitUint(this);
  }
}

class NullContext extends LiteralContext {
  Token? tok;
  TerminalNode? NUL() => getToken(CELParser.TOKEN_NUL, 0);
  NullContext(LiteralContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterNull(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitNull(this);
  }
}

class BoolFalseContext extends LiteralContext {
  Token? tok;
  TerminalNode? CEL_FALSE() => getToken(CELParser.TOKEN_CEL_FALSE, 0);
  BoolFalseContext(LiteralContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterBoolFalse(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitBoolFalse(this);
  }
}

class StringContext extends LiteralContext {
  Token? tok;
  TerminalNode? STRING() => getToken(CELParser.TOKEN_STRING, 0);
  StringContext(LiteralContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterString(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitString(this);
  }
}

class DoubleContext extends LiteralContext {
  Token? sign;
  Token? tok;
  TerminalNode? NUM_FLOAT() => getToken(CELParser.TOKEN_NUM_FLOAT, 0);
  TerminalNode? MINUS() => getToken(CELParser.TOKEN_MINUS, 0);
  DoubleContext(LiteralContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterDouble(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitDouble(this);
  }
}

class BoolTrueContext extends LiteralContext {
  Token? tok;
  TerminalNode? CEL_TRUE() => getToken(CELParser.TOKEN_CEL_TRUE, 0);
  BoolTrueContext(LiteralContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterBoolTrue(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitBoolTrue(this);
  }
}

class IntContext extends LiteralContext {
  Token? sign;
  Token? tok;
  TerminalNode? NUM_INT() => getToken(CELParser.TOKEN_NUM_INT, 0);
  TerminalNode? MINUS() => getToken(CELParser.TOKEN_MINUS, 0);
  IntContext(LiteralContext ctx) {
    copyFrom(ctx);
  }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.enterInt(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is CELListener) listener.exitInt(this);
  }
}
