import 'functions/functions.dart';

class Dispatcher {
  Dispatcher(List<Overload> overloads) {
    add(overloads);
  }

  final Map<String, Overload> _overloads = {};

  Overload? findOverload(String name) {
    return _overloads[name];
  }

  void add(List<Overload> functions) {
    for (final o in functions) {
      _overloads[o.name] = o;
    }
  }
}
