(*========== FIRST QUESTION ==========*)
fun curry f a b c = f (a,b,c)
fun uncurry f (a,b,c) = f a b c 


(*========== SECOND QUESTION ==========*)
fun fst (x,y) = x
fun snd (x,y) = y


(*========== THIRD QUESTION ==========*)
fun length [] = 0
    | length (x :: xs) = 1 + length xs


(*========== FOURTH QUESTION  ==========*)
fun newList [] ys = ys
    | newList (x :: xs) ys = newList xs (x :: ys)

fun reverse [] = []
    | reverse (x :: xs) = newList (x :: xs) []


(*========== FIFTH QUESTION ==========*)
fun fib 1 a b ans = ans
    | fib n a b ans = fib (n-1) b ans (b + ans)

fun fibonacci n = fib n 0 1 1
