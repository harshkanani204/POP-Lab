(* QUESTION 1 *)
datatype expr = Var of Atom.atom
              | Apply of expr*expr
              | Lambda of Atom.atom*expr


(* QUESTION 2 *)
(* free : expr -> atom set *)
fun free (Var x) = AtomSet.singleton x
    | free (Apply (a,b)) = AtomSet.union(free a,free b)
    | free (Lambda (x,a)) = AtomSet.subtract(free a,x)

(* bound : expr -> atom set *)
fun bound (Lambda (x,a)) = AtomSet.union(AtomSet.singleton x,bound a)
    | bound (Apply(a,b)) = AtomSet.union(bound a,bound b)
    | bound (Var x) = AtomSet.empty


(* QUESTION 3 *)
(* subst : expr -> atom -> expr -> expr *)
fun subst (Var p) x e2 = if Atom.same(p,x) 
                            then e2 
                         else (Var p)
    | subst (Apply(a,b)) x e2 = Apply(subst a x e2,subst b x e2)
    | subst (Lambda(y,a)) x e2 = if Atom.same(y,x) 
                                        then Lambda(y,a) 
                                  else Lambda(y,subst a x e2)


(* QUESTION 4 *)
(* diagonalise = fn : string -> string -> string *)
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