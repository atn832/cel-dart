<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## From CEL to Expr

- Exercise 2: `request.auth.claims.group == 'admin'` gets parsed to the following CEL:
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
