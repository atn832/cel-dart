grammar FirestoreRules;
rulesDefinition: rulesVersion service EOF;
rulesVersion: 'rules_version' '=' STRING;
service: 'service cloud.firestore' '{' '}';
STRING: '\'' .*? '\'';

WHITESPACE: (' ' | '\t' | '\r' | '\n')+ -> skip;
