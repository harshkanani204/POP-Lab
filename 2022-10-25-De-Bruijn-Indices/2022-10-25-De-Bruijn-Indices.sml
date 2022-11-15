(* QUESTION 1 *)
datatype expr = Var of Atom.atom
              | Apply of expr*expr
              | Lambda of Atom.atom*expr

datatype deBruijn = dVar of int
                  | dApply of deBruijn*deBruijn
                  | dLambda of deBruijn

(* QUESTION 2 *)
(* diagonalise : string -> string -> string *)
fun diagonalise x y = if (String.isPrefix x y) 
                        then (y ^ "p") 
                      else (x ^ "p")

(* diagA : string -> atom -> string *)
fun diagA x a = let val p = a
            in
                diagonalise (Atom.toString p) x
            end

(* fresh : atom set -> atom *)
fun fresh atomset = let fun foo (p, q) = diagA q p
                in
                    Atom.atom(AtomSet.foldl foo "" atomset)
                end


(* helper : string list -> AtomSet -> deBruijn -> expr *)
fun helper list set (dVar i) = let val nth = List.nth (list, i - 1)
                                    in
                                        Var (Atom.atom nth)
                                    end
                             | helper list set (dApply (x, y)) = Apply (helper list set x, helper list set y)
                             | helper list set (dLambda a) = let val nList = Atom.toString(fresh set) :: list val nSet = AtomSet.add(set, fresh set)
                                                                in
                                                                    Lambda (fresh set, helper nList nSet a)
                                                                end

(* deBruijnToLambda : deBruijn -> expr *)
fun deBruijnToLambda deBruijn = helper [] AtomSet.empty deBruijn;