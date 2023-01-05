# cel-dart

This project parses and evaluates Common Expression Language (CEL) programs. For example based on the input `request.auth.claims.group=='admin'` and a `request` object, the library will evaluate whether the stattement is `true` or `false`. CEL (see the [spec](https://github.com/google/cel-spec)) is a language used by many security projects such as Firestore and Firebase Storage. This project is a simplified port of <https://github.com/google/cel-go>.

## Architecture

Here's the mechanism from CEL code (a `String`) to evaluation:

1. The user sets up an Environment. An Environment is a map that declares custom functions and types.
1. The CEL code is parsed into a CEL tree by a Parser.
1. The CEL tree is traversed and converted into an Abstract Syntax Tree (AST). The type name of that AST is `Expr`.
1. The AST and the Environment are wrapped into a Program.
1. The Program gets evaluated into a Value. Evaluation is done in two steps
   1. A Planner traverses the AST and converts it into an Interpretable.
   1. Program evaluates the Interpretable into a Value.

## Differences with cel-go

The main difference besides being incomplete is that cel-go defines the `Expr` architecture with Protobuf, while this project defines `Expr` as native Dart. This is mostly for convenience, but we might integrate Protobuf later for feature parity.

## Features

| Operator | Description | Supported |
| --- | --- | --- |
| a.f | field access | ✅ |
| a() | call | ❌ |
| a[i] | Index | ❌ |
| !a -a | Unary negation | ❌ |
| a/b a%b a*b | Multiplicative operators | ❌ |
| a+b a-b | Additive operators | ❌ |
| a>b a>=b a | Relational operators | ❌ |
| a in b | Existence in list or map | ❌ |
| a is type | Type comparison, where type can be bool, int, float, number, string, list, map, timestamp, duration, path or latlng | ❌ |
| a==b a!=b | Comparison operators | ✅ |
| a && b | Conditional AND | ✅ |
| a \|\| b | Conditional OR | ✅ |
| a ? true_value : false_value | Ternary expression | ❌ |

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
