fun concat [] xs = xs
    | concat (y :: ys) xs = y :: concat ys xs

fun append [] y = [y]
    | append (x :: xs) y = x :: append xs y

fun concatSlow xs [] = xs
    | concatSlow xs (y :: ys) = concatSlow (append xs y) ys

(* FIRST QUESTION *)
fun curry f a b c = f (a,b,c)
fun uncurry f (a,b,c) = f a b c 


(* SECOND QUESTION *)
fun fst (x,y) = x
fun snd (x,y) = y


(* THIRD QUESTION *)
fun length [] = 0
    | length (x :: xs) = 1 + length xs


(* FOURTH QUESTION  *)
fun reverse [] = []
    | reverse (x :: xs) = concat (reverse xs) [x]


(* FIFTH QUESTION *)
fun fib n = if n <= 2
    then 1
        else fib (n-1) + fib (n-2)

(* TRYING *)