(* QUESTION 1 *)
(* `map : ('a -> 'b) -> 'a list -> 'b list` *)
fun map f [] = []
    | map f (x :: xs) = f x :: map f xs

(* QUESTION 2 *)
