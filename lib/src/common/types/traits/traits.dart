// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/traits/traits.go

enum Traits {
  // AdderType types provide a '+' operator overload.
  AdderType,
  // ComparerType types support ordering comparisons '<', '<=', '>', '>='.
  ComparerType,
  // ContainerType types support 'in' operations.
  ContainerType,
  // DividerType types support '/' operations.
  DividerType,
  // FieldTesterType types support the detection of field value presence.
  FieldTesterType,
  // IndexerType types support index access with dynamic values.
  IndexerType,
  // IterableType types can be iterated over in comprehensions.
  IterableType,
  // IteratorType types support iterator semantics.
  IteratorType,
  // MatcherType types support pattern matching via 'matches' method.
  MatcherType,
  // ModderType types support modulus operations '%'
  ModderType,
  // MultiplierType types support '*' operations.
  MultiplierType,
  // NegatorType types support either negation via '!' or '-'
  NegatorType,
  // ReceiverType types support dynamic dispatch to instance methods.
  ReceiverType,
  // SizerType types support the size() method.
  SizerType,
  // SubtractorType type support '-' operations.
  SubtractorType
}
