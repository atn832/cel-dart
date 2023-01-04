echo 1
antlr4-parse FirestoreRules.g4 rulesDefinition -tree -tokens -trace 1_sample_rules_version.txt
echo 
echo 2
antlr4-parse FirestoreRules.g4 rulesDefinition -tree -tokens -lexer 2_service.txt
echo 
echo 3
antlr4-parse FirestoreRules.g4 rulesDefinition -tree -tokens -trace 3_empty_match.txt
echo 
echo 4
antlr4-parse FirestoreRules.g4 rulesDefinition -tree -tokens -lexer -trace 4_match.txt
# echo 
# echo 5
# antlr4-parse FirestoreRules.g4 rulesDefinition -tree -tokens -lexer -trace 5_recursive_wildcard.txt
