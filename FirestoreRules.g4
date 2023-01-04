grammar FirestoreRules;
service: rulesVersion EOF;
rulesVersion: 'rules_version' '=' STRING;
STRING: '\'' .*? '\'';

WHITESPACE: (' ' | '\t' | '\r' | '\n')+ -> skip;
