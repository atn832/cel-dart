import 'package:cel/src/interpreter/activation.dart';

abstract class Attribute {
  resolve(Activation activation);
}

class MaybeAttribute implements Attribute {
  MaybeAttribute(this.namespaceAttributes);

  final List<NamespaceAttribute> namespaceAttributes;

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L490
  @override
  resolve(Activation activation) {
    for (final attribute in namespaceAttributes) {
      try {
        return attribute.resolve(activation);
      } catch (_) {
        continue;
      }
    }
    throw Exception('Not found');
  }
}

abstract class NamespaceAttribute implements Attribute {}

class AbsoluteAttribute extends NamespaceAttribute {
  AbsoluteAttribute(this.namespaceName);

  final String namespaceName;

  // See https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L294.
  @override
  resolve(Activation activation) {
    try {
      return activation.resolveName(namespaceName);
    } catch (e) {
      throw Exception("Missing attribute $this.");
    }
  }
}
