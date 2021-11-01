# Lambda Calculus with let and let-rec

Consider variants of lambda calculus λ-calculus ⊆ λ-let ⊆ λ-letrec
where the former adds the syntactic sugar of non-recursive `let` and
the latter adds `letrec`.

1. Define abstract syntax for λ-let and λ-letrec as a SML datatype.

2. Write the conversion λ-let to λ-calculus.

## Recursion (bonus, ungraded).

As described in the class, recursion is done in λ-calculus using a
fixed point combinator like `Y`.

1. Give a conversion from λ-letrec to λ-let and then to λ-calculus
   making use of the fixed point combinator.

2. How does one handle mutual recursion ? Hint: use pairing
   construction.
