import 'package:cel/cel.dart';

void main() {
  final input = "request.auth.claims.group == 'admin'";
  final e = Environment();
  final ast = e.compile(input);
  final p = Program(e, ast);
  print(p.evaluate({
    'request': {
      'auth': {
        'claims': {'group': 'admin'}
      }
    }
  }));
}
