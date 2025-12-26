# cel-dart

[![pub package](https://img.shields.io/pub/v/cel.svg)](https://pub.dartlang.org/packages/cel)
[![Unit Tests](https://github.com/atn832/cel-dart/actions/workflows/test.yml/badge.svg)](https://github.com/atn832/cel-dart/actions/workflows/test.yml)

This project parses and evaluates Common Expression Language (CEL) programs against some inputs. For example, based on the code `request.auth.claims.group=='admin'` and a `request` object as input, the library will evaluate whether the statement is `true` or `false`. CEL (see the [spec](https://github.com/google/cel-spec)) is a language used by many security projects such as Firestore and Firebase Storage. This project is a simplified port of <https://github.com/google/cel-go>.

## Usage

```dart
import 'package:cel/cel.dart';

void main() {
  final input = "request.auth.claims.group == 'admin'";
  final e = Environment.standard();
  final ast = e.compile(input);
  final p = e.makeProgram(ast);
  print(p.evaluate({
    'request': {
      'auth': {
        'claims': {'group': 'admin'}
      }
    }
  }));
}
```

Prints out `true`.

## Differences with cel-go

The main difference is that cel-go supports checking types at compilation time, whereas we throw runtime errors at evaluation time. Also we don't support the `timestamps` nor `durations` Protobufs, type conversions and the `type` keyword.

## Features

This table is based on <https://github.com/google/cel-spec/blob/master/doc/langdef.md>.

| CEL Literal | Description | Supported |
| --- | --- | --- |
| `null` | Null Literal | ✅ |
| `true` and `false` | Bool Literal | ✅ |
| `"abc"` | String Literal | ✅ |
| `-13`, `0xff` | Int Literal | ✅ |
| `12u` | Uint Literal | ✅ |
| `12.6` | Double Literal | ✅ |
| `b"abc"` | Bytes Literals | ✅ |
| `user.id == "abc"` | Operators | See table below |

| Structures | Description | Supported
| --- | --- | --- |
| `[a, b]` | List | ✅ |
| `{'name': 'cel', 35 : true}` | Map | ✅ |
| timestamp | google.protobuf.Timestamp | ❌ |
| duration | google.protobuf.Duration | ❌ |

### Operators

This table comes from <https://firebase.google.com/docs/rules/rules-language#operators_and_operator_precedence>.

| Operator | Description | Supported |
| --- | --- | --- |
| `a.f` | field access | ✅ |
| `a()` | call | ✅ |
| `a[i]` | Index | ✅ |
| `!a`, `-a` | Unary negation | ✅ |
| `a/b`, `a%b`, `a*b` | Multiplicative operators | ✅ |
| `a+b`, `a-b` | Additive operators | ✅ |
| `a>b`,  `a>=b` | Relational operators | ✅ |
| `a in b` | Existence in list or map | ✅ |
| `a is type` | Type comparison, where type can be bool, int, float, number, string, list, map, timestamp, duration, path or latlng | ❌ |
| `a==b`, `a!=b` | Comparison operators | ✅ |
| `a && b` | Conditional AND | ✅ |
| `a \|\| b` | Conditional OR | ✅ |
| `a ? true_value : false_value` | Ternary expression | ✅ |

### Functions

From <https://github.com/google/cel-spec/blob/master/doc/langdef.md#functions>.

| Symbol | Type | Description |  |
|:---:|:---:|:---:|---|
| `!_` | (bool) -> bool | logical not | ✅ |
| `-_` | (int) -> int | negation | ✅ |
|  | (double) -> double | negation | ✅ |
| `_!=_` | (A, A) -> bool | inequality | ✅ |
| `_%_` | (int, int) -> int | arithmetic | ✅ |
|  | (uint, uint) -> uint | arithmetic | untested |
| `_&&_` | (bool, bool) -> bool | logical and | ✅ |
|  | (bool, ...) -> bool | logical and (variadic) | ✅ |
| `_*_` | (int, int) -> int | arithmetic | ✅ |
|  | (uint, uint) -> uint | arithmetic | ✅ |
|  | (double, double) -> double | arithmetic | ✅ |
| `_+_` | (int, int) -> int | arithmetic | ✅ |
|  | (uint, uint) -> uint | arithmetic | ✅ |
|  | (double, double) -> double | arithmetic | ✅ |
|  | (string, string) -> string | String concatenation. | ✅ |
|  | (bytes, bytes) -> bytes | bytes concatenation | ❌ |
|  | (list(A), list(A)) -> list(A) | List concatenation. | ✅ |
|  | (google.protobuf.Timestamp, google.protobuf.Duration) -> google.protobuf.Timestamp | arithmetic | ❌ |
|  | (google.protobuf.Duration, google.protobuf.Timestamp) -> google.protobuf.Timestamp | arithmetic | ❌ |
|  | (google.protobuf.Duration, google.protobuf.Duration) -> google.protobuf.Duration | arithmetic | ❌ |
| `_-_` | (int, int) -> int | arithmetic | ✅ |
|  | (uint, uint) -> uint | arithmetic | ✅ |
|  | (double, double) -> double | arithmetic | ✅ |
|  | (google.protobuf.Timestamp, google.protobuf.Timestamp) -> google.protobuf.Duration | arithmetic | ❌ |
|  | (google.protobuf.Timestamp, google.protobuf.Duration) -> google.protobuf.Timestamp | arithmetic | ❌ |
|  | (google.protobuf.Duration, google.protobuf.Duration) -> google.protobuf.Duration | arithmetic | ❌ |
| `_/_` | (int, int) -> int | arithmetic | ✅ |
|  | (uint, uint) -> uint | arithmetic | ✅ |
|  | (double, double) -> double | arithmetic | ✅ |
| `_<=_` | (bool, bool) -> bool | ordering | ✅ |
|  | (int, int) -> bool | ordering | ✅ |
|  | (uint, uint) -> bool | ordering | ✅ |
|  | (double, double) -> bool | ordering | ✅ |
|  | (string, string) -> bool | ordering | ✅ |
|  | (bytes, bytes) -> bool | ordering | ❌ |
|  | (google.protobuf.Timestamp, google.protobuf.Timestamp) -> bool | ordering | ❌ |
|  | (google.protobuf.Duration, google.protobuf.Duration) -> bool | ordering | ❌ |
| `_<_` | (bool, bool) -> bool | ordering | ✅ |
|  | (int, int) -> bool | ordering | ✅ |
|  | (uint, uint) -> bool | ordering | ✅ |
|  | (double, double) -> bool | ordering | ✅ |
|  | (string, string) -> bool | ordering | ✅ |
|  | (bytes, bytes) -> bool | ordering | ❌ |
|  | (google.protobuf.Timestamp, google.protobuf.Timestamp) -> bool | ordering | ❌ |
|  | (google.protobuf.Duration, google.protobuf.Duration) -> bool | ordering | ❌ |
| `_==_` | (A, A) -> bool | equality | ✅ |
| `_>=_` | (bool, bool) -> bool | ordering | ✅ |
|  | (int, int) -> bool | ordering | ✅ |
|  | (uint, uint) -> bool | ordering | ✅ |
|  | (double, double) -> bool | ordering | ✅ |
|  | (string, string) -> bool | ordering | ✅ |
|  | (bytes, bytes) -> bool | ordering | ❌ |
|  | (google.protobuf.Timestamp, google.protobuf.Timestamp) -> bool | ordering | ❌ |
|  | (google.protobuf.Duration, google.protobuf.Duration) -> bool | ordering | ❌ |
| `_>_` | (bool, bool) -> bool | ordering | ✅ |
|  | (int, int) -> bool | ordering | ✅ |
|  | (uint, uint) -> bool | ordering | ✅ |
|  | (double, double) -> bool | ordering | ✅ |
|  | (string, string) -> bool | ordering | ✅ |
|  | (bytes, bytes) -> bool | ordering | ❌ |
|  | (google.protobuf.Timestamp, google.protobuf.Timestamp) -> bool | ordering | ❌ |
|  | (google.protobuf.Duration, google.protobuf.Duration) -> bool | ordering | ❌ |
| `_?_:_` | (bool, A, A) -> A | The conditional operator. See above for evaluation semantics. Will evaluate the test and only one of the remaining sub-expressions. | ✅ |
| `_[_]` | (list(A), int) -> A | list indexing. | ✅ |
|  | (map(A, B), A) -> B | map indexing. | ✅ |
| `in` | (A, list(A)) -> bool | list membership. | ✅ |
|  | (A, map(A, B)) -> bool | map key membership. | ✅ |
| _\|\|_ | (bool, bool) -> bool | logical or | ✅ |
|  | (bool, ...) -> bool | logical or (variadic) | ✅ |
| `bool` | type(bool) | type denotation | ❌ |
| `bytes` | type(bytes) | type denotation | ❌ |
|  | (string) -> bytes | type conversion | ❌ |
| `contains` | string.(string) -> bool | Tests whether the string operand contains the substring. | ✅ |
| `double` | type(double) | type denotation | ❌ |
|  | (int) -> double | type conversion | ❌ |
|  | (uint) -> double | type conversion | ❌ |
|  | (string) -> double | type conversion | ❌ |
| `duration` | (string) -> google.protobuf.Duration | Type conversion. Duration strings should support the following suffixes: "h" (hour), "m" (minute), "s" (second), "ms" (millisecond), "us" (microsecond), and "ns" (nanosecond). Duration strings may be zero, negative, fractional, and/or compound. Examples: "0", "-1.5h", "1m6s" | ❌ |
| `dyn` | type(dyn) | type denotation | ❌ |
|  | (A) -> dyn | type conversion | ❌ |
| `endsWith` | string.(string) -> bool | Tests whether the string operand ends with the suffix argument. | ✅ |
| `getDate` | google.protobuf.Timestamp.() -> int | get day of month from the date in UTC, one-based indexing | ❌ |
|  | google.protobuf.Timestamp.(string) -> int | get day of month from the date with timezone, one-based indexing | ❌ |
| `getDayOfMonth` | google.protobuf.Timestamp.() -> int | get day of month from the date in UTC, zero-based indexing | ❌ |
|  | google.protobuf.Timestamp.(string) -> int | get day of month from the date with timezone, zero-based indexing | ❌ |
| `getDayOfWeek` | google.protobuf.Timestamp.() -> int | get day of week from the date in UTC, zero-based, zero for Sunday | ❌ |
|  | google.protobuf.Timestamp.(string) -> int | get day of week from the date with timezone, zero-based, zero for Sunday | ❌ |
| `getDayOfYear` | google.protobuf.Timestamp.() -> int | get day of year from the date in UTC, zero-based indexing | ❌ |
|  | google.protobuf.Timestamp.(string) -> int | get day of year from the date with timezone, zero-based indexing | ❌ |
| `getFullYear` | google.protobuf.Timestamp.() -> int | get year from the date in UTC | ❌ |
|  | google.protobuf.Timestamp.(string) -> int | get year from the date with timezone | ❌ |
| `getHours` | google.protobuf.Timestamp.() -> int | get hours from the date in UTC, 0-23 | ❌ |
|  | google.protobuf.Timestamp.(string) -> int | get hours from the date with timezone, 0-23 | ❌ |
|  | google.protobuf.Duration.() -> int | get hours from duration | ❌ |
| `getMilliseconds` | google.protobuf.Timestamp.() -> int | get milliseconds from the date in UTC, 0-999 | ❌ |
|  | google.protobuf.Timestamp.(string) -> int | get milliseconds from the date with timezone, 0-999 | ❌ |
|  | google.protobuf.Duration.() -> int | milliseconds from duration, 0-999 | ❌ |
| `getMinutes` | google.protobuf.Timestamp.() -> int | get minutes from the date in UTC, 0-59 | ❌ |
|  | google.protobuf.Timestamp.(string) -> int | get minutes from the date with timezone, 0-59 | ❌ |
|  | google.protobuf.Duration.() -> int | get minutes from duration | ❌ |
| `getMonth` | google.protobuf.Timestamp.() -> int | get month from the date in UTC, 0-11 | ❌ |
|  | google.protobuf.Timestamp.(string) -> int | get month from the date with timezone, 0-11 | ❌ |
| `getSeconds` | google.protobuf.Timestamp.() -> int | get seconds from the date in UTC, 0-59 | ❌ |
|  | google.protobuf.Timestamp.(string) -> int | get seconds from the date with timezone, 0-59 | ❌ |
|  | google.protobuf.Duration.() -> int | get seconds from duration | ❌ |
| `int` | type(int) | type denotation | ❌ |
|  | (uint) -> int | type conversion | ❌ |
|  | (double) -> int | Type conversion. Rounds toward zero, then errors if result is out of range. | ❌ |
|  | (string) -> int | type conversion | ❌ |
|  | (enum E) -> int | type conversion | ❌ |
|  | (google.protobuf.Timestamp) -> int | Convert timestamp to int64 in seconds since Unix epoch. | ❌ |
| `list` | type(list(dyn)) | type denotation | ❌ |
| `map` | type(map(dyn, dyn)) | type denotation | ❌ |
| `matches` | (string, string) -> bool | Matches first argument against regular expression in second argument. | ✅ |
|  | string.(string) -> bool | Matches the self argument against regular expression in first argument. | ✅ |
| `null_type` | type(null) | type denotation | ❌ |
| `size` | (string) -> int | string length | ❌ |
|  | (bytes) -> int | bytes length | ❌ |
|  | (list(A)) -> int | list size. | ❌ |
|  | (map(A, B)) -> int | map size. | ❌ |
| `startsWith` | string.(string) -> bool | Tests whether the string operand starts with the prefix argument. | ✅ |
| `string` | type(string) | type denotation | ❌ |
|  | (int) -> string | type conversion | ❌ |
|  | (uint) -> string | type conversion | ❌ |
|  | (double) -> string | type conversion | ❌ |
|  | (bytes) -> string | type conversion | ❌ |
|  | (timestamp) -> string | type conversion, using the same format as timestamp string parsing | ❌ |
|  | (duration) -> string | type conversion, using the same format as duration string parsing | ❌ |
| `timestamp` | (string) -> google.protobuf.Timestamp | Type conversion of strings to timestamps according to RFC3339. Example: "1972-01-01T10:00:20.021-05:00" | ❌ |
| `type` | type(dyn) | type denotation | ❌ |
|  | (A) -> type(dyn) | returns type of value | ❌ |
| `uint` | type(uint) | type denotation | ❌ |
|  | (int) -> uint | type conversion | ❌ |
|  | (double) -> uint | Type conversion. Rounds toward zero, then errors if result is out of range. | ❌ |
|  | (string) -> uint | type conversion | ❌ |
| `E` (for fully-qualified enumeration E) | (int) -> enum E | type conversion when in int32 range, otherwise error | ❌ |
|  | (string) -> enum E | type conversion for unqualified symbolic name, otherwise error | ❌ |

## Additional information

If you are curious how it was made, or want to contribute, you may find this reading list useful:

* <https://firebase.google.com/docs/rules>
* <https://codelabs.developers.google.com/codelabs/cel-go/>
* [CEL language definition](https://github.com/google/cel-go/blob/master/parser/gen/CEL.g4)
* [Expr protobuf](https://github.com/googleapis/googleapis/tree/master/google/api/expr/v1beta1)
* <https://github.com/google/cel-go>

### Architecture

Here's the mechanism from CEL code (a `String`) to evaluation:

1. The user instantiates an [Environment]. In cel-go, they can pass some environment variables. We have skipped porting this so far.
1. The user calls [Environment.compile] with CEL code (a `String`), and gets back an Abstract Syntax Tree (AST).
    1. Under the hood, [Environment.compile] relies on [Parser], which itself uses [CELParser], an ANTLR generated Parser for CEL.
    1. [CELParser] converts the CEL code into a CEL tree (a [StartContext]).
    1. Then Parser traverses the CEL tree into an [Expr], which is the actual AST.
    1. Finally Environment wraps the [Expr] into an [Ast].
1. The user instantiates a [Program] by passing the Environment and the AST. Upon initialization, the Program calls [Planner.plan], which traverses the AST and converts it into an [Interpretable] for later use.
1. Whenever the user wants to evaluate the Program, they call [Program.evaluate] with some inputs (eg a [Map]), and get a value as a result. It evaluates the Interpretable using the inputs into a return value.

The meat of the code is in [Parser.visit] and [Planner.plan].

### Implementation details

* Difference between [Value.value] and [Value.convertToNative]: While both are the same in the case of primitive wrappers such as [IntValue], [DoubleValue]... they are different for [ListValue] and [MapValue]. For example for a [ListValue], [ListValue.value] is a `List<Value>`, while [Value.convertToNative] will return `List<non-Value type>`.
* `environmentOptions` and [`standardDeclarations`](https://github.com/atn832/cel-dart/blob/f40cde8793c4c5a1f16be186de3c859ff1cead0e/lib/src/checker/standard.dart) don't actually do anything yet. In the future, they may be used to check whether some function has indeed been declared in [Interpretable.planCall](https://github.com/atn832/cel-dart/blob/85646886e5c829832bed9a5e5b23a519c403e4ce/lib/src/interpreter/planner.dart#L53) when it calls resolveFunction. Doing so might help throw an Exception early if the function name is not an declared function.
* In cel-go, [`Parser.visit`](https://github.com/google/cel-go/blob/442811f1e440a2052c68733a4dca0ab3e8898948/parser/parser.go#L359-L443) returns `any`. In cel-dart, we return [`Expr`](https://github.com/atn832/cel-dart/blob/a0502299bf58d0869f9620d51b6af35bf10d8f0b/lib/src/parser/parser.dart#L24), making it more type safe.
* How does `a in b` get processed? `in` is listed in [standardOverloads](https://github.com/atn832/cel-dart/blob/79a049cd9e9b40a31dc6165e6864d04261189b16/lib/src/interpreter/functions/standard.dart#L121). It is used in [StdLibrary](https://github.com/atn832/cel-dart/blob/7a251505c44ce6d8501f4c7967dfddf3d5294691/lib/src/cel/library.dart#L18) to [add them to the Dispatcher](https://github.com/atn832/cel-dart/blob/85ccf2ac813129679823621c16d43bf50680305b/lib/src/cel/options.dart#L13) during initialization. During evaluation, the planner finds the Overload implementation by calling [Dispatcher.findOverload](https://github.com/atn832/cel-dart/blob/85646886e5c829832bed9a5e5b23a519c403e4ce/lib/src/interpreter/planner.dart#L76). Eventually, the `CallExpr('@in')` calls the [Overload] implementation with the call to [contains](https://github.com/atn832/cel-dart/blob/493bdc9ff1cef90f27573fbf304f30e3e0bb6265/lib/src/interpreter/functions/standard.dart#L125).
* In cel-go defines the `Expr` architecture with Protobuf, while this project defines `Expr` as native Dart. This is mostly to save time by avoiding a lot of boilerplate code. We might integrate Protobuf later if the need arises.

### Re-generating CELParser

1. Run `./lib/src/parser/gen/generate.sh`.
1. Using Visual Studio Code, in `CELParser.dart` replace the regex `\(\(1 << _la\) & (\d+)\)` by `bitwiseAnd(pow(2, _la), $1)`.
