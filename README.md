# cel-dart

This project parses and evaluates Common Expression Language (CEL) programs against some inputs. For example based on the input `request.auth.claims.group=='admin'` and a `request` object, the library will evaluate whether the statement is `true` or `false`. CEL (see the [spec](https://github.com/google/cel-spec)) is a language used by many security projects such as Firestore and Firebase Storage. This project is a simplified port of <https://github.com/google/cel-go>.

## Architecture

Here's the mechanism from CEL code (a `String`) to evaluation:

1. The user instantiates an [Environment]. In cel-go, they can pass some environment variables. We have skipped porting this so far.
1. The user calls [Environment.compile] with CEL code (a `String`), and gets back an Abstract Syntax Tree (AST).
    1. Under the hood, [Environment.compile] relies on [Parser], which itself uses [CELParser], an ANTLR generated Parser for CEL.
    1. [CELParser] converts the CEL code into a CEL tree (a [StartContext]).
    1. Then Parser traverses the CEL tree into an [Expr], which is the actual AST.
    1. Finally Environment wraps the [Expr] into an [Ast].
1. The user instnatiates a [Program] by passing the Environment and the AST. Upon initialization, the Program calls [Planner.plan], which traverses the AST and converts it into an [Interpretable] for later use.
1. Whenever the user wants to evaluate the Program, they call [Program.evaluate] with some inputs (eg a [Map]), and get a value as a result. It evaluates the Interpretable using the inputs into a return value.

The meat of the code is in [Parser.visit] and [Planner.plan].

## Differences with cel-go

The main difference besides being incomplete is that cel-go defines the `Expr` architecture with Protobuf, while this project defines `Expr` as native Dart. This is mostly for convenience, but we might integrate Protobuf later for feature parity.

## Features

This table is based on https://github.com/google/cel-spec/blob/master/doc/langdef.md.

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
| [a, b] | List | ✅ |
| {'name': 'cel', 35 : true} | Map | ✅ |

| Feature | Supported |
| --- | --- |
| Properly unescapes all strings | ❌ |
| Custom functions | ❌ |
| Type checking | ❌ |
| Parses to Expr Protobuf | ❌ |

### Operators

This table comes from <https://firebase.google.com/docs/rules/rules-language#operators_and_operator_precedence>.

| Operator | Description | Supported |
| --- | --- | --- |
| a.f | field access | ✅ |
| a() | call | ❌ |
| a[i] | Index | ❌ |
| !a -a | Unary negation | ✅ |
| a/b a%b a*b | Multiplicative operators | ✅ |
| a+b a-b | Additive operators | ✅ |
| a>b a>=b | Relational operators | ✅ |
| a in b | Existence in list or map | ❌ |
| a is type | Type comparison, where type can be bool, int, float, number, string, list, map, timestamp, duration, path or latlng | ❌ |
| a==b a!=b | Comparison operators | ✅ |
| a && b | Conditional AND | ✅ |
| a \|\| b | Conditional OR | ✅ |
| a ? true_value : false_value | Ternary expression | ❌ |

## Usage

```dart
import 'package:cel/cel.dart';

void main() {
  final input = "request.auth.claims.group == 'admin'";
  final e = Environment();
  final ast = e.compile(input);
  final p = Program(e, ast, StdLibrary().programOptions);
  print(p.evaluate({
    'request': {
      'auth': {
        'claims': {'group': 'admin'}
      }
    }
  }));
}
```

## Additional information

If you are curious how it was made, or want to contribute, you may find this reading list useful:

* <https://firebase.google.com/docs/rules>
* <https://codelabs.developers.google.com/codelabs/cel-go/>
* [CEL language definition](https://github.com/google/cel-go/blob/master/parser/gen/CEL.g4)
* [Expr protobuf](https://github.com/googleapis/googleapis/tree/master/google/api/expr/v1beta1)
* <https://github.com/google/cel-go>