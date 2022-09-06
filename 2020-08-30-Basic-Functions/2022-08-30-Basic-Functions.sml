(*========== FIRST QUESTION ==========*)

(* curry : ('a * 'b * 'c -> 'd) -> 'a -> 'b -> 'c -> 'd *)
(* uncurry : ('a -> 'b -> 'c -> 'd) -> 'a * 'b * 'c -> 'd *)
fun curry f a b c = f (a,b,c)
fun uncurry f (a,b,c) = f a b c 


(*========== SECOND QUESTION ==========*)
(* fst : 'a * 'b -> 'a *)
(* snd : 'a * 'b -> 'b *)
fun fst (x,y) = x
fun snd (x,y) = y


(*========== THIRD QUESTION ==========*)
(* length : 'a list -> int *)
fun length [] = 0
    | length (x :: xs) = 1 + length xs


(*========== FOURTH QUESTION  ==========*)
(* newList : 'a list -> 'a list -> 'a list *)
(* reverse : 'a list -> 'a list *)

fun newList [] ys = ys
    | newList (x :: xs) ys = newList xs (x :: ys)

fun reverse [] = []
    | reverse (x :: xs) = newList (x :: xs) []


(*========== FIFTH QUESTION ==========*)
(* fib : int -> int -> int -> int -> int *)
(* fibonacci : int -> int *)
fun fib 1 a b ans = ans
    | fib n a b ans = fib (n-1) b ans (b + ans)

fun fibonacci n = fib n 0 1 1
