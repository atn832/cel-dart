import 'package:cel/src/cel/library.dart';
import 'package:cel/src/cel/options.dart';
import 'package:cel/src/cel/program.dart';
import 'package:cel/src/common/types/provider.dart';
import 'package:cel/src/common/types/ref/provider.dart';
import '../checker/declaration.dart';
import '../parser/parser.dart';
import 'ast.dart';

class Environment {
  // Port of NewCustomEnv.
  // https://github.com/google/cel-go/blob/9e14003d8a7a856b250c5e6514647dee7d4fd9a2/cel/env.go#L151
  Environment._({List<EnvironmentOption> environmentOptions = const []})
      :
        // Register common CEL types.
        adapter = newRegistry() {
    _configure(environmentOptions);
  }

  /// Creates a program environment configured with the standard library of CEL
  /// functions and macros. The Env value returned can parse and check any CEL
  /// program which builds upon the core features documented in the CEL
  /// specification. See
  /// https://github.com/google/cel-go/blob/9e14003d8a7a856b250c5e6514647dee7d4fd9a2/cel/env.go#L127.
  /// In cel-dart, it is not entirely standard as we do not support timestamp
  /// protos nor macros.
  Environment.standard()
      : this._(environmentOptions: [StandardLibrary().toEnvironmentOption()]);

  /// This is actually not useful yet. See https://github.com/atn832/cel-dart/blob/01b30af236478bbb181a37c60df8405ecfc87052/README.md?plain=1#L245.
  final List<Declaration> declarations = [];
  final List<ProgramOption> programOptions = [];
  final TypeAdapter adapter;

  Ast compile(String text) {
    return Ast(Parser().parse(text));
  }

  // https://github.com/google/cel-go/blob/9e14003d8a7a856b250c5e6514647dee7d4fd9a2/cel/env.go#L378
  Program makeProgram(Ast ast) {
    return Program.custom(this, ast, programOptions);
  }

  // https://github.com/google/cel-go/blob/9e14003d8a7a856b250c5e6514647dee7d4fd9a2/cel/env.go#L472
  void _configure(List<EnvironmentOption> environmentOptions) {
    for (final option in environmentOptions) {
      option(this);
    }
  }
}
