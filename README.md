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

## From CEL to Expr

- Exercise 2 (from <https://codelabs.developers.google.com/codelabs/cel-go/>): `request.auth.claims.group == 'admin'` gets parsed to the following CEL:

```
  Rule start: request.auth.claims.group=='admin'<EOF>
   Rule expr: request.auth.claims.group=='admin'
    Rule conditionalOr: request.auth.claims.group=='admin'
     Rule conditionalAnd: request.auth.claims.group=='admin'
      Rule relation: request.auth.claims.group=='admin'
Token EQUALS ==
       Rule relation: request.auth.claims.group
        Rule calc: request.auth.claims.group
         Rule unary: request.auth.claims.group
          Rule member: request.auth.claims.group
Token DOT .
Token ESC_CHAR_SEQ group
           Rule member: request.auth.claims
Token DOT .
Token ESC_CHAR_SEQ claims
            Rule member: request.auth
Token DOT .
Token ESC_CHAR_SEQ auth
             Rule member: request
              Rule primary: request
Token ESC_CHAR_SEQ request
       Rule relation: 'admin'
        Rule calc: 'admin'
         Rule unary: 'admin'
          Rule member: 'admin'
           Rule primary: 'admin'
            Rule literal: 'admin'
Token RAW 'admin'
```

It then gets compiled to this Expr:
```
{
  "id": 5,
  "ExprKind": {
    "CallExpr": {
      "function": "_==_",
      "args": [
        {
          "id": 4,
          "ExprKind": {
            "SelectExpr": {
              "operand": {
                "id": 3,
                "ExprKind": {
                  "SelectExpr": {
                    "operand": {
                      "id": 2,
                      "ExprKind": {
                        "SelectExpr": {
                          "operand": {
                            "id": 1,
                            "ExprKind": {
                              "IdentExpr": {
                                "name": "request"
                              }
                            }
                          },
                          "field": "auth"
                        }
                      }
                    },
                    "field": "claims"
                  }
                }
              },
              "field": "group"
            }
          }
        },
        {
          "id": 6,
          "ExprKind": {
            "ConstExpr": {
              "ConstantKind": {
                "StringValue": "admin"
              }
            }
          }
        }
      ]
    }
  }
}
```

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

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
