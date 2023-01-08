import 'package:cel/cel.dart';
import 'package:cel/src/checker/declaration.dart';
import 'package:cel/src/checker/standard.dart';
import 'package:cel/src/interpreter/functions/standard.dart';

import 'options.dart';

// https://github.com/google/cel-go/blob/35783e995ccefef460a18a034af7d4ad044f57b4/cel/library.go
abstract class Library {
  List<EnvironmentOption> get compileEnvironmentOptions;
  List<ProgramOption> get programOptions;

  // In cel-go, it is called Lib. Converts a Library to an EnvironmentOption so
  // that it can be applied functionally.
  // https://github.com/google/cel-go/blob/9e14003d8a7a856b250c5e6514647dee7d4fd9a2/cel/library.go#L61
  EnvironmentOption toEnvironmentOption() {
    return (Environment e) {
      // apply
      for (final option in compileEnvironmentOptions) {
        option(e);
      }
      e.programOptions.addAll(programOptions);
    };
  }
}

// stdLibrary implements the Library interface and provides functional options
// for the core CEL features documented in the specification.
class StandardLibrary extends Library {
  @override
  List<ProgramOption> get programOptions => [functions(standardOverloads())];

  /// Returns options for the standard CEL function declarations and macros.
  @override
  List<EnvironmentOption> get compileEnvironmentOptions => [
        _declarations(standardDeclarations)
        // TODO: implement macros.
      ];
}

/// Returns an EnvironmentOption that appends the given `declarations`.
/// https://github.com/google/cel-go/blob/9e14003d8a7a856b250c5e6514647dee7d4fd9a2/cel/options.go#L110
EnvironmentOption _declarations(List<Declaration> declarations) {
  return (Environment e) {
    e.declarations.addAll(declarations);
  };
}
