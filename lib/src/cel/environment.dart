import 'package:cel/src/cel/options.dart';
import 'package:cel/src/common/types/provider.dart';
import 'package:cel/src/common/types/ref/provider.dart';
import '../checker/declaration.dart';
import '../parser/parser.dart';
import 'ast.dart';

class Environment {
  Environment({List<EnvironmentOption> environmentOptions = const []})
      : adapter = newRegistry() {
    _configure(environmentOptions);
  }

  /// This is actually not useful yet. See https://github.com/atn832/cel-dart/blob/01b30af236478bbb181a37c60df8405ecfc87052/README.md?plain=1#L245.
  final List<Declaration> declarations = [];
  final TypeAdapter adapter;

  Ast compile(String text) {
    return Ast(Parser().parse(text));
  }

  // https://github.com/google/cel-go/blob/9e14003d8a7a856b250c5e6514647dee7d4fd9a2/cel/env.go#L472
  void _configure(List<EnvironmentOption> environmentOptions) {
    for (final option in environmentOptions) {
      option(this);
    }
  }
}
