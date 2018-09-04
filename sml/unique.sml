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
    fun  toInt    x  = x
end

structure Empty = struct end
structure U = Unique (Empty)
structure V = Unique (Empty)
