import 'package:cel/src/interpreter/attribute_factory.dart';
import 'package:cel/src/interpreter/dispatcher.dart';
import 'package:equatable/equatable.dart';

import '../interpreter/activation.dart';
import '../interpreter/interpretable.dart';
import '../interpreter/interpreter.dart';
import 'ast.dart';
import 'checked_expression.dart';
import 'environment.dart';
import 'options.dart';

class Program extends Equatable {
  /// Makes a custom program. However the usual way to create a Program is
  /// by calling [Environment.newProgram] since it automatically applies the
  /// [Environment]'s options to the Program.
  /// Port of https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/cel/program.go#L150.
  Program.custom(this.environment, this.ast,
      [List<ProgramOption> options = const []]) {
    // Build the dispatcher, interpreter, and default program value.
    dispatcher = Dispatcher([]);

    // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/cel/program.go#L183-L190
    final attributeFactory = AttributeFactory();
    _interpreter = Interpreter(
        attributeFactory: attributeFactory,
        dispatcher: dispatcher,
        adapter: environment.adapter);

    // Configure the program via the ProgramOption values.
    // https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/cel/program.go#L162-L169
    for (final option in options) {
      // Apply the option to this program.
      option(this);
    }

    // TODO: implement AttributeFactory to support global variables.
    // See https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/interpreter/attributes.go#L30.

    // Skipped porting Decorators and other optimizations.
    _initInterpretable();
  }

  final Environment environment;
  final Ast ast;

  late final Dispatcher dispatcher;
  late final Interpreter _interpreter;
  late final Interpretable _interpretable;

  // Shortcut: cel-go returns a Val.
  dynamic evaluate(Map<String, dynamic> input) {
    // Skipped porting Pools since there is no concurrency in this
    // implementation.
    final Activation vars = EvalActivation(input);
    return _interpretable.evaluate(vars).convertToNative();
  }

  void _initInterpretable() {
    final checkedExpression = _astToCheckedExpr(ast);
    _interpretable = _interpreter.interpet(checkedExpression);
  }

  @override
  List<Object?> get props => [environment, ast, dispatcher];

  @override
  bool? get stringify => true;
}

CheckedExpression _astToCheckedExpr(Ast ast) {
  return CheckedExpression(ast.expression);
}
