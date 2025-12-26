import 'package:cel/src/interpreter/activation.dart';
import 'package:cel/src/interpreter/interpretable.dart';
import 'package:equatable/equatable.dart';

abstract class Attribute extends Equatable {
  dynamic resolve(Activation activation);
  void addQualifier(Qualifier qualifier);

  @override
  bool? get stringify => true;
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
    throw Exception('Could not find ${toString()} in environment $activation.');
  }

  @override
  List<Object?> get props => [namespaceAttributes];
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

  @override
  List<Object?> get props => [namespaceName, qualifiers];
}

class RelativeAttribute extends Attribute {
  RelativeAttribute(this.operand);

  final Interpretable operand;

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L570
  @override
  resolve(Activation activation) {
    // final value = operand.evaluate(activation);
    // TODO: support qualifiers.
    throw UnimplementedError();
  }

  @override
  void addQualifier(Qualifier qualifier) {
    // TODO: implement addQualifier
    throw UnimplementedError();
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

abstract class Qualifier extends Equatable {
  qualify(Activation activation, object);

  @override
  bool? get stringify => true;
}

class StringQualifier extends Qualifier {
  StringQualifier(this.value);

  final String value;

  @override
  qualify(Activation activation, object) {
    if (object == null) {
      throw StateError('Trying to read value of key $value on $object');
    }
    return object[value];
  }

  @override
  List<Object?> get props => [value];
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

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L376
  @override
  resolve(Activation activation) {
    // Note: used a shortcut. Used the raw value instead of BooleanValue.
    // Note: cel-go uses expression.resolve. Perhaps some optimization to not
    // evaluate everything?
    return condition.evaluate(activation).value
        ? truthy.evaluate(activation)
        : falsy.evaluate(activation);
  }

  @override
  List<Object?> get props => [condition, truthy, falsy];
}
