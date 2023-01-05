import 'package:cel/src/interpreter/attribute.dart';
import 'package:cel/src/interpreter/interpretable.dart';

class AttributeFactory {
  Attribute maybeAttribute(String name) {
    return MaybeAttribute([
      // Skipped `this.container.ResolveCandidateNames(name)`.
      AbsoluteAttribute(name)
    ]);
  }

  Attribute relativeAttribute(Interpretable eval) {
    return RelativeAttribute(eval);
  }

  // https://github.com/google/cel-go/blob/32ac6133c6b8eca8bb76e17e6ad50a1eb757778a/interpreter/attributes.go#L594
  Qualifier qualifier(dynamic value) {
    if (value is String) {
      return StringQualifier(value);
    } else {
      throw StateError('Unsupported qualifier type ${value.runtimeType}');
    }
  }
}
