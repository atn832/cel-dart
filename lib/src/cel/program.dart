import 'ast.dart';
import 'environment.dart';
import 'interpretable.dart';
import 'interpreter.dart';

class Program {
  // Port of
  // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/cel/program.go#L150.
  Program(this.environment, this.ast) {
    interpreter = Interpreter();
    // TODO: implement Dispatcher to support Function calls.
    // TODO: implement AttributeFactory to support global variables.
    // See https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/interpreter/attributes.go#L30.

    // Skipped porting Decorators and other optimizations.
    _initInterpretable();
  }

  final Environment environment;
  final Ast ast;
  late Interpreter interpreter;
  late Interpretable interpretable;

  void _initInterpretable() {
    interpretable = interpreter.interpet();
  }
}
