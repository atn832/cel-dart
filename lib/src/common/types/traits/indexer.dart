import 'package:cel/src/common/types/ref/value.dart';

// Indexer permits random access of elements by index 'a[b()]'.
abstract class Indexer {
  // Get the value at the specified index or error.
  Value get(Value index);
}
