(* QUESTION 1 *)
signature SORT = sig
    type t
    val sort : t list -> t list
end

signature ORD_KEY =
sig
    type ord_key
    (* abstract type of keys that have a total order *)

    val compare : ord_key * ord_key -> order
    (* comparison function for the ordering on keys *)

end (* ORD_KEY *)


functor QSort ( O : ORD_KEY ) : SORT = struct
    type t = O.ord_key

    fun great a b = (case O.compare (a,b) of
            GREATER => true
        | _ => false)

    fun sort [] = []
        | sort (x::xs) =
            let
                val (left,right) = List.partition (great x) xs
            in
                sort(left) @ [x] @ sort(right)
            end
end

(* QUESTION 2 *)
structure IntOrd : ORD_KEY = struct
    type ord_key = int
    val compare = Int.compare
end

structure quickSort = QSort(IntOrd)

fun quicksort x = quickSort.sort x