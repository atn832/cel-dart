// Port of https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/operators/operators.go.
enum Operators {
  // Symbolic operators.
  Conditional("_?_:_"),
  LogicalAnd("_&&_"),
  LogicalOr("_||_"),
  LogicalNot("!_"),
  Equals("_==_"),
  NotEquals("_!=_"),
  Less("_<_"),
  LessEquals("_<=_"),
  Greater("_>_"),
  GreaterEquals("_>=_"),
  Add("_+_"),
  Subtract("_-_"),
  Multiply("_*_"),
  Divide("_/_"),
  Modulo("_%_"),
  Negate("-_"),
  Index("_[_]"),
  OptIndex("_[?_]"),
  OptSelect("_?._");

  const Operators(this.name);

  final String name;
}
