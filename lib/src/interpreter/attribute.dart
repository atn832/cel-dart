import 'package:cel/src/interpreter/activation.dart';
import 'package:cel/src/interpreter/interpretable.dart';

abstract class Attribute {
  dynamic resolve(Activation activation);
  void addQualifier(Qualifier qualifier);
}

class MaybeAttribute extends Attribute {
  MaybeAttribute(this.namespaceAttributes);

  final List<NamespaceAttribute> namespaceAttributes;

  // Very simplified compared to https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L451.
  @override
  void addQualifier(Qualifier qualifier) {
    for (final attribute in namespaceAttributes) {
      attribute.addQualifier(qualifier);
    }
  }

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

abstract class NamespaceAttribute extends Attribute {}

class AbsoluteAttribute extends NamespaceAttribute {
  AbsoluteAttribute(this.namespaceName);

  final String namespaceName;
  final List<Qualifier> qualifiers = [];

  // See https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L294.
  @override
  resolve(Activation activation) {
    try {
      // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L300
      final object = activation.resolveName(namespaceName);
      return applyQualifiers(activation, object, qualifiers);
    } catch (e) {
      throw Exception("Missing attribute $this.");
    }
  }

  @override
  void addQualifier(Qualifier qualifier) {
    qualifiers.add(qualifier);
  }

  dynamic applyQualifiers(
      Activation activation, object, List<Qualifier> qualifiers) {
    var result = object;
    for (final qualifier in qualifiers) {
      result = qualifier.qualify(activation, result);
    }
    return result;
  }
}

class RelativeAttribute extends Attribute {
  RelativeAttribute(this.operand);

  Interpretable operand;

  @override
  resolve(Activation activation) {
    // TODO: implement resolve
    throw UnimplementedError();
  }

  @override
  void addQualifier(Qualifier qualifier) {
    // TODO: implement addQualifier
  }
}

abstract class Qualifier {
  qualify(Activation activation, object);
}

class StringQualifier extends Qualifier {
  StringQualifier(this.value);

  final String value;

  @override
  qualify(Activation activation, object) {
    return object[value];
  }
}

class ConditionalAttribute extends Attribute {
  ConditionalAttribute(
      {required this.condition, required this.truthy, required this.falsy});

  final Interpretable condition;
  final Interpretable truthy;
  final Interpretable falsy;

  @override
  void addQualifier(Qualifier qualifier) {
    // TODO: implement addQualifier
    throw UnimplementedError();
  }

  @override
  resolve(Activation activation) {
    return condition.evaluate(activation)
        ? truthy.evaluate(activation)
        : falsy.evaluate(activation);
  }
}
