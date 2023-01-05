import 'package:cel/src/interpreter/attribute.dart';

class AttributeFactory {
  Attribute maybeAttribute(String name) {
    return MaybeAttribute([
      // Skipped `this.container.ResolveCandidateNames(name)`.
      AbsoluteAttribute(name)
    ]);
  }
}
