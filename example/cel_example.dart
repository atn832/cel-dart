import 'package:cel/cel.dart';

void main() {
  // final input = 'request.auth != null && request.auth.uid == userId';
  // From CEL Colab, exercise 2.
  final input = "request.auth.claims.group == 'admin'";
  final e = Parser().parse(input);
  print(e);
}
