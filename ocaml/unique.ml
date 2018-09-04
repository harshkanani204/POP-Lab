module type UNIQUE = sig
  type uid
  val allocate : unit -> uid
  val toInt    : uid  -> int
end

module Unique (E : sig end) : UNIQUE =
struct
  type uid = int
  let current     = ref 0
  let allocate () = let x = !current in (current := x + 1 ; x)
  let toInt    x  = x
end

module Empty = struct end
module U  = Unique(Empty)
module V  = Unique(Empty)
