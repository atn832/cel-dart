abstract class Activation {
  resolveName(namespaceName);
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
}
