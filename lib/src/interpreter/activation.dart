import 'package:equatable/equatable.dart';

abstract class Activation extends Equatable {
  resolveName(namespaceName);

  @override
  bool? get stringify => true;
}

class EvalActivation extends Activation {
  EvalActivation(this.input);

  final Map<String, dynamic> input;

  @override
  resolveName(namespaceName) {
    if (!input.containsKey(namespaceName)) {
      throw Exception('No value for variable $namespaceName');
    }
    return input[namespaceName];
  }

  @override
  List<Object?> get props => [input];
}
