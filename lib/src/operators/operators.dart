// Port of https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/operators/operators.go.
enum Operators {
  // Symbolic operators.
  conditional("_?_:_"),
  logicalAnd("_&&_"),
  logicalOr("_||_"),
  logicalNot("!_"),
  equals("_==_"),
  notEquals("_!=_"),
  less("_<_"),
  lessEquals("_<=_"),
  greater("_>_"),
  greaterEquals("_>=_"),
  add("_+_"),
  subtract("_-_"),
  multiply("_*_"),
  divide("_/_"),
  modulo("_%_"),
  negate("-_"),
  // Renamed from index to avoid conflicting with `Enum.index`.
  indexer("_[_]"),
  optIndex("_[?_]"),
  optSelect("_?._");

  const Operators(this.name);

  final String name;
}
