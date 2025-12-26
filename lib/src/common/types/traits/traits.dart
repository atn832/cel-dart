// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/traits/traits.go

enum Traits {
  // AdderType types provide a '+' operator overload.
  adderType,
  // ComparerType types support ordering comparisons '<', '<=', '>', '>='.
  comparerType,
  // ContainerType types support 'in' operations.
  containerType,
  // DividerType types support '/' operations.
  dividerType,
  // FieldTesterType types support the detection of field value presence.
  fieldTesterType,
  // IndexerType types support index access with dynamic values.
  indexerType,
  // IterableType types can be iterated over in comprehensions.
  iterableType,
  // IteratorType types support iterator semantics.
  iteratorType,
  // MatcherType types support pattern matching via 'matches' method.
  matcherType,
  // ModderType types support modulus operations '%'
  modderType,
  // MultiplierType types support '*' operations.
  multiplierType,
  // NegatorType types support either negation via '!' or '-'
  negatorType,
  // ReceiverType types support dynamic dispatch to instance methods.
  receiverType,
  // SizerType types support the size() method.
  sizerType,
  // SubtractorType type support '-' operations.
  subtractorType
}
