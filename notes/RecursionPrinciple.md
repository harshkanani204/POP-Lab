# Recursion principle.

Let `T` be an algebraic data type (possibly recursive). The recursion
principle, or the recursor, for a type `T` is a function that captures
the essence of defining a function _recursively_ from `T` to an
arbitrary type `'b`, i.e. the recursor `recT` of `T` essentially gives
a function of the type `T -> 'b` for arbitrary `'b` but it requires
some arguments for this purpose. What these arguments is, what their
types are and what purpose they serve is what we explain in this note.

While the recursor can be defined for any algebraic datatype defined
using the `datatype` key word in SML, a running example would be for
lists. The list is an inbuilt data type in SML but for illustrating we
re-define this explicitly.


```sml

datatype 'a List = nil | cons of 'a * 'a List

```

The effect of this definition is the following

1. It gives birth to a new (polymorphic type) `List` with one
   parameter given by `'a`

2. It defines two new values `nil` and `cons` with types `nil : 'a
   List` and `cons : 'a * 'a List -> 'a List` respectively.

## The type of recursor

The recursor `recList` takes two arguments, one each for the
constructor `nil` and `cons` and returns a value of type `'a List ->
'b`. The argument corresponding to `nil` should be of type `'b` and
the argument corresponding to `cons` should be of type `'a * 'b ->
'b`. Given below is the explicit type of `recList`.

```sml
val recList :  'b              (* nil  : 'a List *)
            -> ('a * 'b -> 'b) (* cons : 'a * 'a List -> 'a List *)
            -> 'a List -> 'b   (* result : list function to 'b *)
```


In general, for a type `T` its recursor `recT` takes as many arguments
as there are constructors for `T` and returns a value of type `T ->
'b`. The argument that associated with the constructor `C : τ -> T`,
where `τ` can possibly recursively refer to `T`, has type `τ₁ -> 'b`
where `τ₁` is obtained from `τ` by replacing any (recursive)
occurrence of `T` by `'b'. In other words, if `T` is defined as the datatype

```sml
datatype T = ...
           | C of τ
		   | ...
```

the recursor will have type

```sml

val recT :  ...
         -> (τ₁ -> 'b)   (* argument associated with C *)
		 -> ...
		 -> T -> 'b      (* the result type            *)

```

## The semantics of the recursor.

One way to think about an algebraic datatype is to think of them as
trees where the nodes are marked with constructors. For example, the
list [1,2,5,3], with our constructor definition can be seen pictorially
as

```sml

  	+---------+
    |cons 1 . |
  	+-------|-+
  			|
   	   	 +--v-------+
   	   	 | cons 2 .	|
   	   	 +--------|-+
   				  |
   			   +--v-------+
   			   | cons 5 . |
   			   +--------|-+
   	   	   	   	   	   	|
                     +--v-------+
  					 | cons 3 .	|
  					 +--------|-+
  							  |
   	   	   	   	   	   	   	+---+
  							|nil|
  						   	+---+

```

Recall that the recursor `recList` takes two arguments one
corresponding to the constructor `nil` and the other corresponding to
the constructor `cons`. Let us call these arguments by the variables
`N` and `C` respectively. Then pictorially the `recList` does
the following.



```sml

         -------- recList N C --------|
		 |							  V
		 |
   	+---------+		   	   	   	    +---------+
    |cons 1 . |		  			    |C    1 . |
  	+-------|-+		  			    +-------|-+
  			|		  			            |
   	   	 +--v-------+ 			         +--v-------+
   	   	 | cons 2 .	| 			         | C    2 . |
   	   	 +--------|-+ 			         +--------|-+
   				  |	   	   	   	                  |
   			   +--v-------+		               +--v-------+
   			   | cons 5 . |		               | C    5 . |
   			   +--------|-+		               +--------|-+
   	   	   	   	   	   	|		                        |
                     +--v-------+                    +--v-------+
  					 | cons 3 .	|                    | C    3 . |
  					 +--------|-+                    +--------|-+
  							  |	                              |
   	   	   	   	   	   	   	+---+                           +---+
  							|nil|                           | N |
  	   	   	   	   	   	   	+---+                           +---+

```

That is `recList N C ` can be visualised as replacing the `nil` node
with the constant `N` and the `cons` node with `C`. We can give the
complete definition the `recList` function.

```sml

fun recList N C nil           = N
  | recList N C (cons (x,xs)) = C (x , recList N C xs)

```

Notice that for the argument `xs` the recursor goes about replacing
stuff recursively.
