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
  index_("_[_]"),
  optIndex("_[?_]"),
  optSelect("_?._"),

  // Named operators, must not have be valid identifiers.
  // Skipped porting NotStrictlyFalse.
  // Note: Cannot use reserved keyword `in`.
  in_("@in");

  const Operators(this.name);

  final String name;

  static final operators = Map<String, Operators>.unmodifiable({
    "+": Operators.add,
    "/": Operators.divide,
    "==": Operators.equals,
    ">": Operators.greater,
    ">=": Operators.greaterEquals,
    "in": Operators.in_,
    "<": Operators.less,
    "<=": Operators.lessEquals,
    "%": Operators.modulo,
    "*": Operators.multiply,
    "!=": Operators.notEquals,
    "-": Operators.subtract,
  });
}
