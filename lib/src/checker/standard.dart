// https://github.com/google/cel-go/blob/35783e995ccefef460a18a034af7d4ad044f57b4/checker/standard.go#L52
import 'package:cel/src/common/overloads/overloads.dart';
import 'package:cel/src/interpreter/functions/functions.dart';

import 'declaration.dart';

// Declare overloads with only the name. The actual implementation is found via
// the Type, then finding out that it's a Receiver, and then calling `receive`.
final List<Declaration> standardDeclarations = [
  // String functions.
  FunctionDeclaration(Overload(Overloads.startsWith.name))
];
