// https://github.com/google/cel-go/blob/377a0bba20d07926e0583b4e604509ca7f3583b7/common/types/traits/receiver.go

// Receiver interface for routing instance method calls within a value.
abstract class Receiver {
  // Receive accepts a function name, overload id, and arguments and returns
  // a value.
  dynamic receive(String function, String overload, List<dynamic> arguments);
}
