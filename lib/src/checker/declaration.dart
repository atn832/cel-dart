// Manual implementation of the Protobuf
// https://github.com/google/cel-go/blob/35783e995ccefef460a18a034af7d4ad044f57b4/vendor/google.golang.org/genproto/googleapis/api/expr/v1alpha1/checked.pb.go#L556
import 'package:cel/src/interpreter/functions/functions.dart';

class Declaration {}

class FunctionDeclaration extends Declaration {
  FunctionDeclaration(this.function);

  final Overload function;
}
