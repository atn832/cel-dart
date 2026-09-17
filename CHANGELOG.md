## 0.6.0

Thank you [leoafarias](https://github.com/leoafarias) for this change!

* **BREAKING CHANGE**: Make a missing map key throw a `no_such_field` error instead of null. ([PR-15](https://github.com/atn832/cel-dart/pull/15))

## 0.5.6

Thank you [leoafarias](https://github.com/leoafarias) for these changes! [PR-12](https://github.com/atn832/cel-dart/pull/12)

- Implemented `size()` for strings, lists and maps.
- Fixed exception when making calls without arguments.
- `type(1)` and any other unimplemented unary function now throw `UnsupportedError('Function type with one argument is not implemented by this runtime.')`.
- Fixed conversion of lists. It now supports any kind of List, including `List<dynamic>`. Also added `NullValue` and `ListValue` to the pass-through list.
- Fixed a few null exceptions and throw Errors with actual messages instead.

## 0.5.5

Thank you [leoafarias](https://github.com/leoafarias) for these changes!

- Make && and || absorb errors from either decisive operand ([PR-13](https://github.com/atn832/cel-dart/pull/13)).
- Keep the activation out of missing-attribute error messages ([PR-14](https://github.com/atn832/cel-dart/pull/14)).

## 0.5.4+1

Fixed string list variables ([PR 5](https://github.com/atn832/cel-dart/pull/5)). Thank you [gatzsche](https://github.com/gatzsche)!

## 0.5.3

Fixed lists, indexing and function calls on Web ([PR 3](https://github.com/atn832/cel-dart/pull/3)).

## 0.5.2

Fixed runtime error when running cel in Flutter Web in debug mode (commit [e957ae3](https://github.com/atn832/cel-dart/commit/e957ae325f1798dab2ad3648aa61ed9ca0bfda9d)).

## 0.5.1+1

Cleaned up README.

## 0.5.1

- Improved display of runtime exceptions.
- Implemented concatenation of list with the `+` operator (commit [5b618cd](https://github.com/atn832/cel-dart/commit/5b618cd70cad3dbfd798fb47946f259e53e18339).

## 0.5.0+1

Relaxed version of `collection` from ^1.17.0 down to ^1.16.0 for Flutter projects.

## 0.5.0

Initial version.
