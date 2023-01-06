// https://github.com/google/cel-go/blob/a29469fda231aa37802d476ef818e2224c25e157/common/overloads/overloads.go

// String function names.
enum Overloads {
  contains("contains"),
  endsWith("endsWith"),
  matches("matches"),
  startsWith("startsWith");

  const Overloads(this.name);

  final String name;
}
