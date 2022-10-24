(* QUESTION 1 *)
datatype expr = Var of Atom.atom
              | Apply of expr*expr
              | Lambda of Atom.atom*expr

datatype lamdaLet = lVar of Atom.atom
                  | lApply of lamdaLet*lamdaLet
                  | lLambda of Atom.atom*lamdaLet
                  | lLet of Atom.atom*lamdaLet*lamdaLet

datatype lamdaLetrec = lrVar of Atom.atom
                     | lrApply of lamdaLetrec*lamdaLetrec
                     | lrLambda of Atom.atom*lamdaLetrec
                     | lrLet of Atom.atom*lamdaLetrec*lamdaLetrec

(* QUESTION 2 *)
(* letTolambda = fn : lamdaLet -> expr *)
fun letTolambda (lVar x) = Var x
    | letTolambda (lApply (a,b)) = Apply (letTolambda a, letTolambda b)
    | letTolambda (lLambda (x,a)) = Lambda (x,letTolambda a)
    | letTolambda (lLet (x,a,b)) = Apply (Lambda (x,letTolambda b), letTolambda a) 