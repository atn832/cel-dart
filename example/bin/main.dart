import 'package:cel/cel.dart';

void main() {
  final input = "request.auth.claims.group == 'admin'";
  final e = Environment.standard();
  final ast = e.compile(input);
  final p = e.makeProgram(ast);
  print(p.evaluate({
    'request': {
      'auth': {
        'claims': {'group': 'admin'}
      }
    }
  }));
}
