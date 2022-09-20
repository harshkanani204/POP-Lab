(* QUESTION 1 *)
(* foldl : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b *)
fun foldl f a [] = a
  | foldl f a (x::xs) = foldl f (f (x, a)) xs

(* foldr : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b *)
fun foldr f a [] = a
  | foldr f a (x::xs) = f(x, (foldr f a xs))



(* QUESTION 2 *)
(* sum : int list -> int *)
val addall = op +
fun sum l = foldr addall 0 l



(* QUESTION 3 *)
(* partition = fn : ('a -> bool) -> 'a list -> 'a list * 'a list *)
fun partition compare list = let fun anfn (a,(p,q)) = if compare a then (a::p,q)
                                                       else (p,a::q)
                             in 
                                 foldr anfn ([],[]) list
                             end

(* map = fn : ('a -> 'b) -> 'a list -> 'b list *)
fun map f list = let fun anfn (a,b) = (f (a)) :: b
                   in 
                        foldr anfn [] list
                   end

(* reverse = fn : 'a list -> 'a list *)
fun reverse list = let fun anfn (p,q) = p :: q
                  in
                        foldr anfn [] list
                  end

(* datatype 'a Find = Found of 'a | LookingFor of int *)
datatype 'a Find = LookingFor of int
                 | Found of 'a

(* nAux = fn : 'a list * int -> 'a Find *)
fun nAux (list,i) = let fun anfn (x,LookingFor(a)) = if (a=0) then Found(x)
                                                     else LookingFor(a-1)
                        | anfn (x,Found(a)) = Found(a)
                  in
                        foldl anfn (LookingFor(i)) list
                  end

(* datatype 'a option = None | ValueIs of 'a *)
datatype 'a option = None | ValueIs of 'a

(* nth = fn : 'a list * int -> 'a option *)
fun nth (list,i) = case nAux(list,i) of
                    LookingFor(a) => None
                    | Found(a)    => ValueIs(a)