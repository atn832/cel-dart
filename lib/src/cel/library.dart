import 'package:cel/src/interpreter/functions/standard.dart';

import 'options.dart';

// https://github.com/google/cel-go/blob/35783e995ccefef460a18a034af7d4ad044f57b4/cel/library.go
abstract class Library {
  List<ProgramOption> get programOptions;
}

// stdLibrary implements the Library interface and provides functional options for the core CEL
// features documented in the specification.
class StdLibrary implements Library {
  @override
  List<ProgramOption> get programOptions => [functions(standardOverloads())];
}
