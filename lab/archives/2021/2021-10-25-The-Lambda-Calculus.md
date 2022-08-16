# The Lambda calculus : A small functional language

Deadline: 1st November 2021 23:59.

We look at the following simple functional programming language whose
abstract syntax is given as follows.

```
<expr>  := variable                    -- A variable like x, y, z
        | <expr> <expr>                -- e₁ e₂ should mean the function e₁ applied on e₂ (like sml)
		| "fn" variable "=>" <expr>    -- fn x => e  means that function that takes x to e

```

Examples of programs in this language are


```
fn x => x  – The indentity function
fn x y => x – The const function etc.
```

Note: We will not need parenthesis in the AST but when we want to
express programs in this language as a string we will need to put
brackets to disambiguate the application order.

1. Define a type `expr` to capture this abstract syntax using ML data
   types with variables represented as strings
   ```
       type var      = string
	   datatype expr = ...
   ```


2. Consider an expression like `fn x => x y`. Here `x` is a _bound
   variable_ because it occurs in the shadow of the binder `fn x =>
   ..`. However, `y` is a _free variable_. Write a functions `free :
   expr -> var list` to compute the list of free and all the
   Hint: First write down a formal definition for what is the set of
   free variable. We know that there are only three kinds of expressions

   1. A variable `x`
   2. A function application `e₁ e₂`
   3. An function abstraction `fn x => e`

   In each of these case what is the set of free variables ? Write SML
   functions that compute the free, bound and all variables of a given
   lambda calculus expression.

   You can use the standard ML library set implementation.


   ```sml
   (*
   Define a structure of type ORD_KEY for your variables (which is string or you can use Atom)

   In case you are using Atom.atom for your varialbes AtomSet already gives you an implementation
   of sets over Atom.atom. You can use that.

   https://www.classes.cs.uchicago.edu/archive/2015/spring/22620-1/ord-key-sig.html

   *)

   structure StringKey : ORD_KEY = struct
    ...
	...

   end (* structure StringKey *)


   structure StringSet = RedBlackSetFn (StringKey) (* Can use this for string set implementation *)

   ```


3. Write a function `subst : var * expr -> expr -> expr` where `subst
   (x,N) M` substitutes all _free_ occurrence of x in M with N. In
   mathematical notation it is written as `M [x:=N]`.

# Bonus Question (Ungraded)

 A _reduction_ is defined as follows : `(fn x => M) N` reduces to `M[x
 := N]`. Write functions to reduce programs in this language.  This
 code is not as simple as it appears because you need to avoid
 variable captures.

# Variable capture

Substitution can lead to _variable capture_ that has to be taken care
of. For example, consider reducing the expression `M N` where `M` is
`(fn x => fn t => x t)` and `N` is `t`, then the naive reduction
will give `fn t => t t` which is incorrect. In this case we say that
the free variable of `N` is _captured_ by the `fn t => ...`.

To avoid this capture, we need to change the bound variable `t` in the
sub-expression `(fn t => x t)` of `M` to some fresh variable, a
variable that does not occur as free in `N`. But you need to be
careful here such that you do not capture another variable in M. For
example you cannot replace `t` by `x`.

The idea therefore is as follows when performing `M [x := N]`, if `M`
is `fn t => M'` then replace t with something different `(var M' ∪
var N)`.


## Fresh variable calculation and avoiding variable captures.

The best way to avoid variable capture is to freshen all the bound
variables occuring in sub-expressions. You can do this by writing the
following helper function.

1. Write a function `fresh : string list -> string` which will produce
   a fresh variable name, i.e. given `xs : string list`, the string
   `fresh xs` will be different from all the strings in `xs`. There is
   many ways to define this function but an elegant way is using
   [Cantors diagonalisation][cantor]


2. Usin the `fresh` function you might want to write a functio
   that freshens all the bound variables in a given expression e.
   variables fresh for reduction to work out Write a function
   `freshen : var list -> expr -> expr` which will make sure that all
   bound variables of `e` are replaced by fresh variables.

   freshen vs e = let vs' = all variables of e ⋃ vs
                  compute fresh variables from vs' and use it to change
				  the bound variables of e.

[cantor]: <https://en.wikipedia.org/wiki/Cantor%27s_diagonal_argument>
