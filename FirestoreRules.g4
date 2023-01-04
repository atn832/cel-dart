grammar FirestoreRules;
rulesDefinition: rulesVersion? service EOF;
rulesVersion: 'rules_version' '=' STRING;
service: 'service' 'cloud.firestore' '{' match* '}';
match: 'match' PATH '{' match* '}';

PATH: [/{}a-z]+;
// path: PATH_SEGMENT+;
PATH_SEGMENT: '/' NAME|VARIABLE;
// TODO: support underscores etc.
NAME: [a-z0-9]+?;
VARIABLE: '{' NAME '=**'? '}';
STRING: '\'' .*? '\'';

WHITESPACE: (' ' | '\t' | '\r' | '\n')+ -> skip;
COMMENT: '//' (~'\n')* -> skip;
