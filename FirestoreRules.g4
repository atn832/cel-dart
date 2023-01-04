grammar FirestoreRules;
rulesDefinition: rulesVersion? service? EOF;
rulesVersion: 'rules_version' '=' STRING;
service: 'service' 'cloud.firestore' '{' match* '}';
match: 'match' path '{' (allow|match)* '}';
allow: 'allow' ACCESS (',' ACCESS)* ':' CES_EXPRESSION;

ACCESS: 'read' | 'write';
path: pathSegment+;
pathSegment: '/' (NAME|VARIABLE);
// TODO: support underscores etc.
NAME: [a-z0-9]+;
VARIABLE: '{' NAME '}';
STRING: '\'' .*? '\'';
CES_EXPRESSION: 'if' (~'\n')+;

WHITESPACE: (' ' | '\t' | '\r' | '\n')+ -> skip;
COMMENT: '//' (~'\n')* -> skip;
