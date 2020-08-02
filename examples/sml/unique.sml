(*

This module illustrates the notion of transparent and opaque
signatures. It also illustrates the notion of generative functors.

*)

signature UNIQUE = sig
    type uid
    val allocate : unit -> uid
    val toInt    : uid  -> int
end

functor Unique (E : sig end) :> UNIQUE = struct
    type uid         = int
    val  current     = ref 0
    fun  allocate () = let val x = !current in current := x + 1; x end
    fun  alloc ()    = (current := !current +1; !current - 1)
    fun  toInt    x  = x
end

structure Empty = struct end
structure U = Unique (Empty)
structure V = Unique (Empty)
val u = U.allocate
val v = V.allocate

(* Exercise 1.

Load the above in sml and try out the expressions

U.toInt u
U.toInt v
V.toInt u
U.toInt v

and explain the observations.


 *)


(* Exercise 2: Repeat Exercise 1 after modifying the definition of
the functor Unique as given below.

functor Unique (E : sig end) : UNIQUE = struct
...
end

i.e. we use : instead of :>

Explain the observations.

 *)

