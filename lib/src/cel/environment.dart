import '../parser/parser.dart';
import 'ast.dart';

class Environment {
  Ast compile(String text) {
    return Ast(Parser().parse(text));
  }
}
